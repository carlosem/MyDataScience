
####################################################
## This script plots the emissions of all sources ##
## for each of the years 1999, 2002, 2005, 2008   ##
## to verify if they have decreased.              ##
####################################################

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

tot <- aggregate(Emissions ~ year, NEI, sum)

barplot((tot$Emissions)/10^6, names.arg=tot$year, xlab="Year", ylab="PM2.5 Emissions", main="Total Emissions in the United States")

dev.copy(png,'plot1.png')
dev.off()
