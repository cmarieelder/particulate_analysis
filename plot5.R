# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to show how emissions from motor vehicle sources have changed
# from 1999–2008 in Baltimore City.
plot5 <- function() {
    # Load the required packages -----------------------------------------------
    list_of_packages <- c("dplyr", "ggplot2", "ggpmisc")
    lapply(list_of_packages, library, character.only = TRUE)

    # Read data into global environment ----------------------------------------
    source("src/read_particulate_data.R")

    # Set hard-coded variables -------------------------------------------------
    BALTIMORE_FIPS <- "24510"

    # Get SCC data related to motor vehicles -----------------------------------
    scc_vehicle <- subset(SCC, grepl("[Hh]ighway.*Vehicle", SCC.Level.Two))

    # Get Baltimore NEI data that matches the motor vehicle SCC identifiers ----
    nei_vehicle <- NEI %>%
        filter(fips == BALTIMORE_FIPS) %>%
        subset(SCC %in% scc_vehicle$SCC) %>%
        select(year, Emissions, type) %>%
        transform(year = factor(year))

    # Sum the emissions by year ------------------------------------------------
    nei_year <- with(nei_vehicle, tapply(Emissions, year, sum, na.rm = TRUE))
    nei_year_df <- data.frame(year = names(nei_year),
                              total_emissions = nei_year)

    # Create plot of year vs. total emissions ----------------------------------
    title <- "Motor Vehicle PM2.5 Emissions in Baltimore City, MD (1999-2008)"
    nei_year_plot <-
        ggplot(data = nei_year_df, aes(x = year, y = total_emissions, group = 1,
                                       fill = year)) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        geom_smooth(method = "lm", se = FALSE, show.legend = FALSE) +
        stat_poly_eq(formula = y ~ x, label.x = "right", label.y = 1,
                     aes(label = paste(..eq.label.., ..rr.label..,
                                       sep = "~~~")),
                     parse = TRUE) +
        labs(x = "Year", y = "PM2.5 Emissions (tons)", title = title) +
        scale_fill_manual(values = c("brown3", "darkorange2", "darkgoldenrod1",
                                     "chartreuse4")) +
        geom_text(aes(label = format(round(total_emissions), big.mark = ",",
                                     scientific = FALSE)),
                  vjust = 1.6, color = "white", size = 3.5)

    # Generate the plot as a PNG -----------------------------------------------
    png(file = "results/plot5.png")
    print(nei_year_plot)
    dev.off()
}

plot5()
