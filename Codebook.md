# Code book

## Variables

### PM2.5 Emissions Data (\color{red}{\verb|summarySCC_PM25.rds|}summarySCC_PM25.rds):  
This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.  

- \color{red}{\verb|fips|}fips: A five-digit number (represented as a string) indicating the U.S. county  

- \color{red}{\verb|SCC|}SCC: The name of the source as indicated by a digit string (see source code classification table)  

- \color{red}{\verb|Pollutant|}Pollutant: A string indicating the pollutant  

- \color{red}{\verb|Emissions|}Emissions: Amount of PM2.5 emitted, in tons  

- \color{red}{\verb|type|}type: The type of source (point, non-point, on-road, or non-road)  

- \color{red}{\verb|year|}year: The year of emissions recorded

### Source Classification Code Table (\color{red}{\verb|Source_Classification_Code.rds|}Source_Classification_Code.rds):  
This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and any categories may be explored if deemed useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.  

- \color{red}{\verb|SCC|}SCC

- \color{red}{\verb|Data.Category|}Data.Category  

- \color{red}{\verb|Short.Name|}Short.Name  

- \color{red}{\verb|EI.Sector|}EI.Sector  

- \color{red}{\verb|Option.Group|}Option.Group 

- \color{red}{\verb|Option.Set|}Option.Set  

- \color{red}{\verb|SCC.Level.One|}SCC.Level.One  

- \color{red}{\verb|SCC.Level.Two|}SCC.Level.Two  

- \color{red}{\verb|SCC.Level.Three|}SCC.Level.Three  

- \color{red}{\verb|SCC.Level.Four|}SCC.Level.Four  

- \color{red}{\verb|Map.To|}Map.To  

- \color{red}{\verb|Last.Inventory.Year|}Last.Inventory.Year  

- \color{red}{\verb|Created_Date|}Created_Date  

- \color{red}{\verb|Revised_Date|}Revised_Date  

- \color{red}{\verb|Usage.Notes|}Usage.Notes  
