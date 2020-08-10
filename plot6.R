# Author: Cynthia Elder
# Date: 8/2/2020

# Creates a plot to compare emissions from motor vehicle sources in
# Baltimore City with those from Los Angeles County, California,
# and shows which city had greater changes over time in motor vehicle emissions.
plot6 <- function() {
    # Load the required packages -----------------------------------------------
    list_of_packages <- c("dplyr", "ggplot2", "ggpmisc")
    lapply(list_of_packages, library, character.only = TRUE)

    # Read data into global environment ----------------------------------------
    source("src/read_particulate_data.R")

    # Get SCC data related to motor vehicles -----------------------------------
    scc_vehicle <- subset(SCC, grepl("[Hh]ighway.*Vehicle", SCC.Level.Two))

    # Set hard-coded variables --------------------------------------------------
    BALTIMORE_FIPS <- "24510"
    LOS_ANGELES_FIPS <- "06037"

    # Get Baltimore and LA NEI data that matches the motor vehicle SCC IDs
    nei_vehicle <- NEI %>%
        filter(fips == BALTIMORE_FIPS | fips == LOS_ANGELES_FIPS) %>%
        subset(SCC %in% scc_vehicle$SCC) %>%
        select(year, Emissions, fips) %>%
        transform(year = factor(year))
    nei_vehicle$fips[nei_vehicle$fips == BALTIMORE_FIPS] <- "Baltimore City, MD"
    nei_vehicle$fips[nei_vehicle$fips == LOS_ANGELES_FIPS] <- "Los Angeles, CA"

    # Sum the emissions by year and county -------------------------------------
    nei_year_df <- as.data.frame(xtabs(Emissions ~ year + fips,
                                       data = nei_vehicle))
    nei_year_df <- rename(nei_year_df, total_emissions = Freq)

    # Create plots of year vs. total emissions for Baltimore and LA ------------
    year_county_plot <-
        ggplot(data = nei_year_df, aes(x = year, y = total_emissions,
                                       group = fips, fill = year)) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        geom_smooth(method = "lm", se = FALSE, show.legend = FALSE) +
        stat_poly_eq(formula = y ~ x, label.x = "right", label.y = 1,
                     aes(label = paste(..eq.label.., ..rr.label..,
                                       sep = "~~~")),
                     parse = TRUE) +
        facet_wrap(~fips, scales = "free_y", dir = "v") +
        labs(x = "Year", y = "PM2.5 Emissions (tons)",
             title = "Motor Vehicle PM2.5 Emissions in MD and CA (1999-2008)") +
        scale_fill_manual(values = c("brown3", "darkorange2", "darkgoldenrod1",
                                     "chartreuse4")) +
        geom_text(aes(label = format(round(total_emissions), big.mark = ",",
                                     scientific = FALSE)),
                  vjust = 3.5, color = "white", size = 3.5)

    # Generate the plot as a PNG -----------------------------------------------
    png(file = "results/plot6.png")
    print(year_county_plot)
    dev.off()
}

plot6()
