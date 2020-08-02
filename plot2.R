# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

#NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

plot2 <- function() {
  NEI <- transform(NEI, year = factor(year))
  year_emissions <- with(subset(NEI, fips == "24510"), tapply(Emissions, year, sum, na.rm = T))
  year_emissions_df <- data.frame(year = names(year_emissions), total_emissions = year_emissions)

  png(file = "results/plot2.png")
  with(year_emissions_df, plot(year, total_emissions, pch=19,
                               main="Total PM2.5 Emissions in Baltimore City, MD, 1999-2008",
                               xlab="Year", ylab="Total PM2.5 Emissions (tons)"))
  model <- lm(total_emissions ~ as.numeric(year), year_emissions_df) # fit linear model to data
  abline(model, lty=2, lwd = 2, col = "blue") # pass linear model object with line-width default 2
  dev.off()
}
plot2()