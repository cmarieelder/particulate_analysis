# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to show if total emissions from PM2.5 decreased in
# Baltimore City, Maryland from 1999 to 2008, using the base plotting system.
plot2 <- function() {
  # read data into global environment and load constants
  source("src/read_particulate_data.R")
  source("src/particulate_constants.R")
  
  # get data for Baltimore City
  baltimore_nei <- NEI %>%
    transform(year = factor(year)) %>%
    filter(fips == BALTIMORE_FIPS)

  # sum the emissions by year
  year_emissions <- with(baltimore_nei, tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions),
    total_emissions = year_emissions)

  # create the plot of year vs. total emissions, with a regression line, as PNG
  png(file = "results/plot2.png")
  with(year_emissions_df, plot(year, total_emissions, pch = 19,
    main = "Total PM2.5 Emissions in Baltimore City, MD, 1999-2008",
    xlab = "Year", ylab = "Total PM2.5 Emissions (tons)"))
  model <- lm(total_emissions ~ as.numeric(year), year_emissions_df)
  abline(model, lwd = 2, col = "blue")
  dev.off()
}

plot2()