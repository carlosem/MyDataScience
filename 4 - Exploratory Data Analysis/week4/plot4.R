
##############################################################################
## This script plots the emissions for the coal combustion-related sources  ##
## accross the United States for each of the years 1999, 2002, 2005, 2008   ##
## to verify how they changed.                                              ##
##############################################################################

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC[,3] <-as.character(SCC[,3])                  # Collum with the name/description of the source
is_coal <- grepl("[Cc][Oo][Aa][Ll]", SCC[,3])    # Look for the coal combustion-related sources
SCC <- SCC[is_coal,]                             # Select the appropriate collums
scc_name <- as.character(SCC[,1])                # Get the code of that collums


NEI_comb <- subset(NEI, SCC %in% scc_name)

library(ggplot2)
ggplot(NEI_comb, aes(factor(year), Emissions/10^5)) + labs(x = "Year", y = "PM 2.5 Emission") + labs(title = "Coal Combustion Source Emissions from 1999 to 2008") + geom_bar(stat = "identity", width = 0.7) + theme_bw()  



dev.copy(png,'plot4.png')
dev.off()
