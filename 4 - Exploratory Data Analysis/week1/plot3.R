
data=read.table('household_power_consumption.txt',sep=';',header=TRUE, stringsAsFactors = FALSE)

datasub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
tStamp<- strptime(paste( subsetData$Date, subsetData$Time, sep = " " ), format = "%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)
plot(tStamp,datasub$Sub_metering_1,type="l" ,xlab="", ylab="Energy Sub-Metering")
lines(tStamp,datasub$Sub_metering_2, col="red" )
lines(tStamp,datasub$Sub_metering_3, col="blue")
legend( "topright",lty =1, lwd = 2.0, col=c("black","red","blue"), legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3") )
dev.off()