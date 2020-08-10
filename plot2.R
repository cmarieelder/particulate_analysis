# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to show if total emissions from PM2.5 decreased in
# Baltimore City, Maryland from 1999 to 2008, using the base plotting system.
plot2 <- function() {
    # Load the required packages -----------------------------------------------
    library(dplyr)

    # Read data into global environment ----------------------------------------
    source("src/read_particulate_data.R")

    # Set hard-coded variables -------------------------------------------------
    BALTIMORE_FIPS <- "24510"

    # Get data for Baltimore City ----------------------------------------------
    baltimore_nei <- NEI %>%
        filter(fips == BALTIMORE_FIPS)

    # Sum the emissions by year ------------------------------------------------
    nei_year <- with(baltimore_nei, tapply(Emissions, year, sum, na.rm = TRUE))
    nei_year_df <- data.frame(year = as.numeric(names(nei_year)),
                              total_emissions = nei_year)

    # Create base plot of year vs. total emissions, as a PNG -------------------
    png(file = "results/plot2.png")

    par(cex = 1.2, cex.main = 1.0, bg = "aliceblue")
    cols <- c("brown3", "darkorange2", "darkgoldenrod1", "chartreuse4")

    plot_title = "Total PM2.5 Emissions in Baltimore City, MD (1999-2008)"
    nei_year_plot <- with(nei_year_df,
                          barplot(total_emissions ~ year, ylim = c(0,4000),
                                  col = cols, xlab = "Year",
                                  ylab = "Total PM2.5 Emissions (tons)",
                                  main = plot_title))

    # add text to show total emission y-values for each bar in barplot
    text(x = nei_year_plot, y = nei_year_df$total_emissions,
         label = format(round(nei_year_df$total_emissions), big.mark = ",",
                        scientific = FALSE),
         pos = 1, col = "white")

    # adjust for barplot factor scale by offsetting year to min=0
    nei_year_df$year_factor <- nei_year_df$year - min(nei_year_df$year)

    # add linear regression line using factor scale
    model <- lm(total_emissions ~ year_factor, nei_year_df)
    abline(model, lty = 2, lwd = 2, col = "blue")

    # annotate plot with linear regression equation
    model_text <- bquote("" ~ hat(y) == .(round(model$coefficients[2],1))
                         ~ "X + " ~ .(round(model$coefficients[1], 1)) ~ "")
    text(2, max(nei_year_df$total_emissions) * 1.1, model_text, col = "blue")

    dev.off()
}

plot2()
