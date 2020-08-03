# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to show how emissions from coal combustion-related 
# sources have changed from 1999–2008 across the United States.
plot4 <- function() {
  library(dplyr)
  library(ggplot2)

  # read data into global environment
  source("src/read_particulate_data.R")

  # acquire SCC data related to coal combustion
  coal_comb_scc <- subset(SCC,
      grepl("Comb.*Coal", Short.Name) |
      grepl("Comb.*Coal", EI.Sector))

  # get NEI data that matches the coal combustion SCC identifiers
  coal_comb_nei <- NEI %>% subset(SCC %in% coal_comb_scc$SCC) %>%
      select(year, Emissions, type) %>%
      transform(year = factor(year))

  # sum the emissions by year
  year_emissions <- with(coal_comb_nei, tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions),
    total_emissions = year_emissions)

  # create the plot of year vs. total emissions with a regression line
  emissions_plot <-
    ggplot(data = year_emissions_df, aes(year, total_emissions, group = 1)) +
    geom_point(size = 2) +
    geom_smooth(color = "steelblue", method = "lm", se = FALSE) +
    labs(x = "Year", y = "PM2.5 Emissions (tons)",
      title = "Coal Combustion-related PM2.5 Emissions in US, 1999-2008")

  # print the plot to PNG
  png(file = "results/plot4.png")
  print(emissions_plot)
  dev.off()
}

plot4()