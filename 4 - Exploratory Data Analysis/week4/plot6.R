
####################################################################
## This script plots the emissions for the motor vehicle sources  ##
## in Baltimore City and Los Angeles County for each of the years  ##
## 1999, 2002, 2005, 2008 to verify how they changed.             ##                      
####################################################################

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC[,3] <-as.character(SCC[,3])                     # Collum with the name/description of the source
is_motor <- grepl("[Mm][Oo][Tt][Oo][Rr]", SCC[,3])  # Look for the ones with the word "Motor" 
SCC <- SCC[is_motor,]                               # Select the appropriate collums
scc_name <- as.character(SCC[,1])                   # Get the code of that collums


NEI_motor_balt <- subset(NEI, SCC %in% scc_name & fips == "24510")
NEI_motor_balt$city <- "Baltimore City"

NEI_motor_los <- subset(NEI, SCC %in% scc_name & fips == "06037")
NEI_motor_los$city <- "Los Angeles"

NEI_balt_los <- rbind(NEI_motor_balt, NEI_motor_los)

library("ggplot2")

ggplot(NEI_balt_los, aes(factor(year), Emissions/10^5)) + labs(x = "Year", y = "PM 2.5 Emission") + labs(title = "Motor Vehicle Source Emissions from 1999 to 2008") + geom_bar(stat = "identity", width = 0.7) + theme_bw() + facet_grid(.~city)  

dev.copy(png,'plot6.png')
dev.off()






