# Author: Cynthia Elder
# Date: 8/2/2020

# Generates a plot to show whether total PM2.5 emissions, from all sources
# for the years 1999, 2002, 2005, and 2008, decreased in the United
# States, using the base plotting system.
plot1 <- function() {
    # Load the required packages -----------------------------------------------
    library(RColorBrewer)

    # Read data into global environment ----------------------------------------
    source("src/read_particulate_data.R")

    # Sum the emissions by year ------------------------------------------------
    nei_year <- transform(NEI, year = factor(year))
    nei_year <- with(nei_year, tapply(Emissions, year, sum, na.rm = TRUE))
    nei_year_df <- data.frame(year = as.numeric(names(nei_year)),
                              total_emissions = nei_year)

    # Create base plot of year vs. total emissions, as a PNG -------------------
    png(file = "results/plot1.png")

    par(cex = 1.2, cex.main = 1.0, bg = "aliceblue")
    cols <- c("brown3", "darkorange2", "darkgoldenrod1", "chartreuse4")

    title <- "Total PM2.5 Emission in US (1999-2008)"
    nei_year_plot <- with(nei_year_df,
                          barplot(total_emissions ~ year, col = cols,
                                  ylim = c(0, max(total_emissions) * 1.5),
                                  xlab = "Year",
                                  ylab = "Total PM2.5 Emissions (tons)",
                                  main = title))

    # add text to show total emission y-values for each bar in barplot
    text(x = nei_year_plot, y = nei_year_df$total_emissions,
         label = format(round(nei_year_df$total_emissions), big.mark = ",",
                        scientific = FALSE),
         pos = 1, offset = 3, col = "white")

    # adjust for barplot factor scale by offsetting year to min=0
    nei_year_df$year <- nei_year_df$year - min(nei_year_df$year)

    # add linear regression line using factor scale
    model <- lm(total_emissions ~ year, nei_year_df)
    abline(model, lty = 2, lwd = 2, col = "blue")

    # annotate plot with linear regression equation
    model_text <- bquote("" ~ hat(y) == .(round(model$coefficients[2],1))
                         ~ "X + " ~ .(round(model$coefficients[1], 1)) ~ "")
    text(2, max(nei_year_df$total_emissions) * 1.1, model_text, col = "blue")

    dev.off()
}

plot1()
