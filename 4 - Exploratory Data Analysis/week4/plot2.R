
#######################################################
## This script plots the emissions of all sources    ##
## for the Batimore City for each of the years 1999, ##
## 2002, 2005, 2008 to verify if they have decreased.##
#######################################################

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Subset the data frame for Baltimore City
NEI_balt <- subset(NEI, fips == "24510")

tot_balt <- aggregate(Emissions ~ year, NEI_balt, sum)

# Make the plot
barplot(tot_balt$Emissions, names.arg=tot_balt$year, xlab="Year", ylab="PM2.5 Emissions", main="Total PM2.5 Emissions for Baltimore")

dev.copy(png,'plot2.png')
dev.off()
