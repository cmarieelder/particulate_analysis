# Author: Cynthia Elder
# Date: 8/2/2020

# Reads particulate data into global environment, if the objects don't exist.
# This improves run-time of plot functions, by not requiring multiple reads.
# May be an issue if the object already in the global environment is corrupt.

source("src/particulate_constants.R")

if (!file.exists(PARTICULATE_DATA_DIR)) {
  unzip(PARTICULATE_DATA_ZIP, overwrite = FALSE, exdir = PARTICULATE_DATA_DIR)
}

if (!exists("NEI")) {
  NEI <- readRDS(NEI_FILENAME)
}

if (!exists("SCC")) {
  SCC <- readRDS(SCC_FILENAME)
}

