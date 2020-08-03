# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to compare emissions from motor vehicle sources in
# Baltimore City with those from Los Angeles County, California,
# and shows which city had greater changes over time in motor vehicle emissions.
plot6 <- function() {
  library(dplyr)
  library(ggplot2)

  # read data into global environment and load constants
  source("src/read_particulate_data.R")
  source("src/particulate_constants.R")
  
  # get SCC data related to motor vehicles
  vehicle_scc <- subset(SCC, grepl("[Hh]ighway.*Vehicle", SCC.Level.Two))

  # get Baltimore and LA NEI data that matches the motor vehicle SCC identifiers
  vehicle_nei <- NEI %>%
    filter(fips == BALTIMORE_FIPS | fips == LOS_ANGELES_FIPS) %>%
    subset(SCC %in% vehicle_scc$SCC) %>%
    select(year, Emissions, fips) %>%
    transform(year = factor(year))
  vehicle_nei$fips[vehicle_nei$fips == BALTIMORE_FIPS] <- "Baltimore City, MD"
  vehicle_nei$fips[vehicle_nei$fips == LOS_ANGELES_FIPS] <- "Los Angeles, CA"

  # sum the emissions by year and county
  year_emissions_df <- as.data.frame(xtabs(Emissions ~ year + fips,
    data = vehicle_nei))
  year_emissions_df <- rename(year_emissions_df, total_emissions = Freq)

  # create plots of year vs. total emissions for Baltimore and LA
  # adds regression line and sets y-axes to be independent
  emissions_plot <-
    ggplot(data = year_emissions_df, aes(year, total_emissions, group = fips)) +
    geom_point(size = 2) +
    geom_smooth(color = "steelblue", method = "lm", se = FALSE) +
    facet_wrap(~fips, scales = "free_y", dir = "v") +
    labs(x = "Year", y = "PM2.5 Emissions (tons)",
         title = "Motor Vehicle PM2.5 Emissions in MD and CA, 1999-2008")

  # print plot to PNG
  png(file = "results/plot6.png")
  print(emissions_plot)
  dev.off()
}

plot6()