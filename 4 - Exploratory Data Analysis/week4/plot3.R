
###################################################################
## This script plots the emissions for the four types of sources ##
## (point, nonpoint, onroad, nonroad) in Baltimore City for the  ##
## years 1999, 2002, 2005 and 2008 to see which sources have a   ##
## decrease or an increase in emissions.                         ##
###################################################################


NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Subset the data frame for Baltimore City
NEI_balt <- subset(NEI, fips == "24510")

library("plyr")
tot_balt_type <- ddply(NEI_balt, .(type, year), summarize, Emissions = sum(Emissions)) 

library("ggplot2")

qplot(year, Emissions, data = tot_balt_type, group = type, color = type, geom = c("point", "line"), ylab = expression("Total Emissions"), xlab = "Year", main = "Total Emissions in Baltimore City by Type")

dev.copy(png,'plot3.png')
dev.off()

