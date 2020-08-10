# Author: Cynthia Elder
# Date: 8/2/2020

# Generates a plot to show which source types have seen decreases in
# emissions from 1999-2008 for Baltimore City, and which have seen increases,
# using the ggplot2 plotting system.
plot3 <- function() {
    # Load the required packages -----------------------------------------------
    list_of_packages <- c("dplyr", "ggplot2", "ggpmisc")
    lapply(list_of_packages, library, character.only = TRUE)

    # Read data into global environment ----------------------------------------
    source("src/read_particulate_data.R")

    # Set hard-coded variables -------------------------------------------------
    BALTIMORE_FIPS <- "24510"

    # Get data for Baltimore City ----------------------------------------------
    nei_baltimore <- NEI %>%
        filter(fips == BALTIMORE_FIPS) %>%
        select(year, Emissions, type)

    # Sum the emissions by year and type ---------------------------------------
    nei_year_type <- as.data.frame(xtabs(Emissions ~ year + type,
                                         data = nei_baltimore))
    nei_year_type <- rename(nei_year_type, total_emissions = Freq)

    # Create plots of year vs. total emissions for each source type ------------
    plot_title <- "PM2.5 Emissions by Source in Baltimore City, MD (1999-2008)"
    year_type_plot <-
        ggplot(data = nei_year_type, aes(x = year, y = total_emissions,
                                         group = type, fill = year)) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        geom_smooth(method = "lm", se = FALSE, show.legend = FALSE) +
        stat_poly_eq(formula = y ~ x, label.x = "right", label.y = 1,
                     aes(label = paste(..eq.label.., ..rr.label..,
                                       sep = "~~~")),
                     parse = TRUE) +
        facet_wrap(~type, scales = "free_y") +
        labs(x = "Year", y = "PM2.5 Emissions (tons)", title = plot_title) +
        scale_fill_manual(values = c("brown3", "darkorange2", "darkgoldenrod1",
                                     "chartreuse4")) +
        geom_text(aes(label = format(round(total_emissions), big.mark = ",",
                                     scientific = FALSE)),
                  vjust = 2, color = "white", size = 3.5)

    # Generate the plots as a PNG -----------------------------------------------
    png(file = "results/plot3.png")
    print(year_type_plot)
    dev.off()
}

plot3()
