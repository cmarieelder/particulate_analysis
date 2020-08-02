# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.
#NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

plot1 <- function() {
  NEI <- transform(NEI, year = factor(year))
  year_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions), total_emissions = year_emissions)
  with(year_emissions_df, plot(year, total_emissions, pch=19, main="Total PM2.5 Emissions 1999-2008"))
  model <- lm(total_emissions ~ as.numeric(year), year_emissions_df) # fit linear model to data
  abline(model, lty=2, lwd = 2, col = "blue") # pass linear model object with line-width default 2
}
plot1()