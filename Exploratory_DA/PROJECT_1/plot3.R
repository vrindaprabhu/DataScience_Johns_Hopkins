data <- read.csv('household_power_consumption.txt',sep = ';',stringsAsFactors=F)

data.subset <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data.subset$DateTime <- strptime(paste(data.subset$Date, data.subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png(file = 'plot3.png', width = 480, height = 480 )
plot(data.subset$DateTime, as.numeric(data.subset$Sub_metering_1), type="l", ylab="Energy Submetering", xlab="")
lines(data.subset$DateTime , as.numeric(data.subset$Sub_metering_2), type="l", col="red")
lines(data.subset$DateTime , as.numeric(data.subset$Sub_metering_3), type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

