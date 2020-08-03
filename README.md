# particulate_analysis

## Scripts
* <b>`plot1.R`</b>: generates a plot to show whether total PM2.5 emissions, from all sources for the years 1999, 2002, 2005, and 2008, decreased in the United States, using the base plotting system.  

* <b>`plot2.R`</b>: creates a plot to show if total emissions from PM2.5 decreased in Baltimore City, Maryland from 1999 to 2008, using the base plotting system.  

* <b>`plot3.R`</b>: generates a plot to show which source types have seen decreases in emissions from 1999–2008 for Baltimore City, and which have seen increases, using the ggplot2 plotting system.  

* <b>`plot4.R`</b>: creates a plot to show how emissions from coal combustion-related sources have changed from 1999–2008 across the United States.  

* <b>`plot5.R`</b>: creates a plot to show how emissions from motor vehicle sources have changed from 1999–2008 in Baltimore City.  

* <b>`plot6.R`</b>: creates a plot to compare emissions from motor vehicle sources in Baltimore City with those from Los Angeles County, California, and shows which city had greater changes over time in motor vehicle emissions.  

### src files:
* <b>`read_particulate_data.R`</b>: reads particulate data into global environment, if the objects don't exist.  

* <b>`particulate_constants.R`</b>: contains constants for particulate analysis.  

## Exploratory Data Analysis Project
Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). More information about the NEI can be found at the [EPA National Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that used for this assignment are for 1999, 2002, 2005, and 2008.

### Data
The data for this assignment are available from the course web site as a single zip file:  
[Data for Peer Assessment[29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

### Objectives
The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. Any R package may be used to support the analysis.  

Address the following questions and tasks in the exploratory analysis. For each question/task, make a single plot. Unless specified, use any plotting system in R to make the plot.  

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.  

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (`fips == "24510"`) from 1999 to 2008? Use the base plotting system to make a plot answering this question.  

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?  

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?  

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (`fips == "06037"`). Which city has seen greater changes over time in motor vehicle emissions?  

For each plot:  

- Construct the plot and save it to a PNG file.  

- Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that constructs the corresponding plot, i.e. code in `plot1.R` constructs the `plot1.png` plot. The code file should include code for reading the data so that the plot can be fully reproduced. The code that creates the PNG file should also be included. Only include the code for a single plot (i.e. `plot1.R` should only include code for producing `plot1.png`)  

- Upload the PNG file on the Assignment submission page  

- Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

### Completion Criteria
For each question:  

1. Does the plot appear to address the question being asked?  

2. Is the submitted R code appropriate for construction of the submitted plot?  

### References
- This project was created for the [John Hopkins University: Exploratory Data Analysis](https://www.coursera.org/learn/exploratory-data-analysis) course.  
Assignment specification can be found under "Course Project 4".  
