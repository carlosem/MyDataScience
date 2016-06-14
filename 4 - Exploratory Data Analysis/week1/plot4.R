
data=read.table('household_power_consumption.txt',sep=';',header=TRUE, na.strings = "?")
data <- data[complete.cases(data),]

datasub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
tStamp<- strptime(paste(subsetData$Date, subsetData$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(tStamp, datasub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(tStamp, datasub$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(tStamp, datasub$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(tStamp, datasub$Sub_metering_2, type="l", col="red")
lines(tStamp, datasub$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2.5, col=c("black", "red", "blue"))

plot(tStamp, datasub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()