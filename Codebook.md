# Code book

## Variables

### PM2.5 Emissions Data
`summarySCC_PM25.rds`: This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.  

- `fips`: A five-digit number (represented as a string) indicating the U.S. county  

- `SCC`: The name of the source as indicated by a digit string (see source code classification table)  

- `Pollutant`: A string indicating the pollutant  

- `Emissions`: Amount of PM2.5 emitted, in tons  

- `type`: The type of source (point, non-point, on-road, or non-road)  

- `year`: The year of emissions recorded

### Source Classification Code Table
`Source_Classification_Code.rds`: This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and any categories may be explored if deemed useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.  
```
1   SCC
2   Data.Category  
3   Short.Name  
4   EI.Sector  
5   Option.Group 
6   Option.Set  
7   SCC.Level.One  
8   SCC.Level.Two  
9   SCC.Level.Three  
10   SCC.Level.Four  
11   Map.To  
12   Last.Inventory.Year  
13   Created_Date  
14   Revised_Date  
15   Usage.Notes  
```
