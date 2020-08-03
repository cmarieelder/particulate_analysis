# Author: Cynthia Elder
# Date: 8/2/2020

# Generates a plot to show whether total PM2.5 emissions, from all sources 
# for the years 1999, 2002, 2005, and 2008, decreased in the United
# States, using the base plotting system.
plot1 <- function() {
  # read data into global environment
  source("src/read_particulate_data.R")
  
  # sum the emissions by year
  year_emissions <- transform(NEI, year = factor(year))
  year_emissions <- with(year_emissions, tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions),
    total_emissions = year_emissions)

  # create the plot of year vs. total emissions, with regression line, as a PNG
  png(file = "results/plot1.png")
  with(year_emissions_df, plot(year, total_emissions, pch = 19,
    main = "Total PM2.5 Emission in US, 1999-2008", xlab = "Year",
    ylab = "Total PM2.5 Emissions (tons)"))
  model <- lm(total_emissions ~ as.numeric(year), year_emissions_df)
  abline(model, lwd = 2, col = "blue")
  dev.off()
}

plot1()