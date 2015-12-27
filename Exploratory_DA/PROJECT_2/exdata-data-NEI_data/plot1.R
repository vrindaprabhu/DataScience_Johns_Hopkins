library(data.table)
library(ggplot2)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

setkey(summarySCC_PM25, "year") 
PM2_5_US <- summarySCC_PM25[, list(EMISSION=sum(Emissions)), by=key(summarySCC_PM25)] 

png(file = 'plot1.png', width = 480, height = 480 )
barplot(height=PM2_5_US$EMISSION, names.arg=PM2_5_US$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
