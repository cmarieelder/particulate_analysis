# Author: Cynthia Elder
# Date: 8/2/2020

# Reads particulate data into global environment, if the objects don't exist.
# This improves run-time of plot functions, by not requiring multiple reads.
# May be an issue if the object already in the global environment is corrupt.

DATA_DIR <- "data/exdata_data_NEI_data"
if (!file.exists(DATA_DIR)) {
    unzip(paste0(DATA_DIR, ".zip"), overwrite = FALSE, exdir = DATA_DIR)
}

if (!exists("NEI") | !exists("SCC")) {
    NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")
}


