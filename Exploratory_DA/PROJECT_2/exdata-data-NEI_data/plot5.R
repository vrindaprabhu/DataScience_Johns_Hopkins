library(data.table)
library(ggplot2)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

PM2_5_Baltimore <- summarySCC_PM25[fips == "24510"]
setkey(PM2_5_Baltimore, "year")
vehicle_pollute_Baltimore <- PM2_5_Baltimore[type=='ON-ROAD', list(EMISSION=sum(Emissions)), by=key(PM2_5_Baltimore )]
vehicle_plot <- ggplot(vehicle_pollute_Baltimore, aes(factor(year), EMISSION))
vehicle_plot <- vehicle_plot + geom_bar(stat="identity",color='red') +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) + 
  labs(title = 'Total Emissions from motor vehicle sources \nFrom 1999 to 2008 in Baltimore') + 
  theme(plot.title = element_text(hjust = 0.5))

png(file = 'plot5.png', width = 480, height = 480 )
vehicle_plot
dev.off()
