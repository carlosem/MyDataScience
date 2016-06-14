
data=read.table('household_power_consumption.txt',sep=';',header=TRUE, stringsAsFactors = FALSE)

datasub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

tStamp<- strptime(paste(datasub$Date, datasub$Time, sep = " " ), format = "%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(tStamp, datasub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()