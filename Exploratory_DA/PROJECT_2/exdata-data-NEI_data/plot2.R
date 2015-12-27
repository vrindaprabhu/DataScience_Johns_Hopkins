library(data.table)
library(ggplot2)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

setkey(summarySCC_PM25, "year","fips")
PM2_5_Baltimore <- summarySCC_PM25[fips == "24510", list(EMISSION=sum(Emissions)), by=key(summarySCC_PM25)]

png(file = 'plot2.png', width = 480, height = 480 )
barplot(height=PM2_5_Baltimore$EMISSION, names.arg=PM2_5_Baltimore$year,col='blue', xlab="years", ylab=expression('total PM'[2.5]*' emission at Baltimore'),main=expression('Total PM'[2.5]*' emissions at various years at Baltimore'))
dev.off()
