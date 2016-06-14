
data=read.table('household_power_consumption.txt',sep=';',header=TRUE, na.strings = "?")
data <- data[complete.cases(data),]

datasub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

hist(datasub$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

dev.copy(png,'plot1.png')
dev.off()