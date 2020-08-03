# Author: Cynthia Elder
# Date: 8/2/2020

# Generates a plot to show which source types have seen decreases in
# emissions from 1999–2008 for Baltimore City, and which have seen increases,
# using the ggplot2 plotting system.
plot3 <- function() {
  library(ggplot2)
  library(dplyr)

  # read data into global environment and load constants
  source("src/read_particulate_data.R")
  source("src/particulate_constants.R")

  # get data for Baltimore City
  baltimore_nei <- NEI %>%
                  filter(fips == BALTIMORE_FIPS) %>%
                  select(year, Emissions, type)

  # sum the emissions by year and type
  year_type_nei <- as.data.frame(xtabs(Emissions ~ year + type,
    data = baltimore_nei))
  year_type_nei <- rename(year_type_nei, total_emissions = Freq)

  # create plots of year vs. total emissions, with linear regression line,
  # for each source type
  emissions_plot <-
    ggplot(data = year_type_nei, aes(year, total_emissions, group = type)) +
    geom_point(size = 2) +
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(~type, scales = "free_y") +
    labs(x = "Year", y = "PM2.5 Emissions (tons)",
      title = "PM2.5 Emissions by Source in Baltimore City, MD, 1999-2008")

  # generate the plots as a PNG
  png(file = "results/plot3.png")
  print(emissions_plot)
  dev.off()
}

plot3()