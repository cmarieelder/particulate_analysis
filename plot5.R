# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to show how emissions from motor vehicle sources have changed
# from 1999–2008 in Baltimore City.
plot5 <- function() {
  library(dplyr)
  library(ggplot2)
  
  # read data into global environment and load constants
  source("src/read_particulate_data.R")
  source("src/particulate_constants.R")

  # get SCC data related to motor vehicles
  vehicle_scc <- subset(SCC, grepl("[Hh]ighway.*Vehicle", SCC.Level.Two))

  # get Baltimore NEI data that matches the motor vehicle SCC identifiers
  vehicle_nei <- NEI %>%
    filter(fips == BALTIMORE_FIPS) %>%
    subset(SCC %in% vehicle_scc$SCC) %>%
    select(year, Emissions, type) %>%
    transform(year = factor(year))

  # sum emissions by year
  year_emissions <- with(vehicle_nei, tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions),
    total_emissions = year_emissions)

  # create a plot of year vs. total emissions with regression line
  emissions_plot <-
    ggplot(data = year_emissions_df, aes(year, total_emissions, group = 1)) +
    geom_point(size = 2) +
    geom_smooth(color = "steelblue", method = "lm", se = FALSE) +
    labs(x = "Year", y = "PM2.5 Emissions (tons)",
      title = "Motor Vehicle PM2.5 Emissions in Baltimore City, MD, 1999-2008")

  # print the plot to PNG
  png(file = "results/plot5.png")
  print(emissions_plot)
  dev.off()
}

plot5()