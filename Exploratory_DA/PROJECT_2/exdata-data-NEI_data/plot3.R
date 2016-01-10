library(data.table)
library(ggplot2)
library(gridExtra)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

PM2_5_Baltimore <- summarySCC_PM25[fips == "24510"]
setkey(PM2_5_Baltimore, "year","type")
PM2_5_Baltimore_Types <- PM2_5_Baltimore[, list(EMISSION=sum(Emissions)), by=key(PM2_5_Baltimore)]
types_plot_a <- ggplot(PM2_5_Baltimore_Types, aes(year, EMISSION, color = type))
types_plot_a <- types_plot_a + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')

# png(file = 'plot3a.png', width = 480, height = 480 )
# types_plot_a
# dev.off()

PM2_5_Baltimore_Types <- PM2_5_Baltimore[, list(EMISSION=sum(Emissions)), by=key(PM2_5_Baltimore)]
types_plot_b <- ggplot(PM2_5_Baltimore_Types, aes(as.character(year), EMISSION))
types_plot_b <- types_plot_b + geom_bar(stat="identity",colour = 'Blue') + facet_grid(.~type) +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')

# png(file = 'plot3b.png', width = 480, height = 480 )
# types_plot_b 
# dev.off()
# 

png(file = 'plot3.png', width = 480, height = 480 )
grid.arrange(types_plot_a,types_plot_b , nrow = 2)
dev.off()

