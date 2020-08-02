# Of the four of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from
# 1999–2008 for Baltimore City? Which have seen increases in emissions from
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

plot3 <- function() {
  library(ggplot2)
  library(dplyr)
  NEI_baltimore <- NEI %>%
                  filter(fips=="24510") %>%
                  select(year, Emissions, type)
  NEI_df <- as.data.frame(xtabs(Emissions ~ year + type, data=NEI_baltimore))
  NEI_df <- rename(NEI_df, total_emissions = Freq)

  q <- ggplot(data=NEI_df, aes(year, total_emissions, group=type)) +
    geom_point() +
    geom_smooth(method = "lm") +
    facet_wrap(~type, scales="free_y") +
    labs(x="Year", y="PM2.5 Emissions (tons)",
         title="PM2.5 Emissions by Source in Baltimore City, MD, 1999-2008")

  png(file = "results/plot3.png")
  print(q)
  dev.off()
}
plot3()