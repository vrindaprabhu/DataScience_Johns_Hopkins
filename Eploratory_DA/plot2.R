data <- read.csv('household_power_consumption.txt',sep = ';',stringsAsFactors=F)

data.subset <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data.subset$DateTime <- strptime(paste(data.subset$Date, data.subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png(file = 'plot2.png', width = 480, height = 480 )
with(data.subset,plot(x = DateTime, as.numeric(Global_active_power), xlab = '',
                      ylab = 'Global Active Power (kilowatts)', type = 'l'))
dev.off()
