library(data.table)
library(ggplot2)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

coal_combust_US <- merge(source_classification_code,summarySCC_PM25,by='SCC')
setkey(coal_combust_US, "year")
coal_combust_US_pa <- coal_combust_US[, list(EMISSION=sum(Emissions)), by=key(coal_combust_US)]
coal_plot <- ggplot(coal_combust_US_pa, aes(factor(year), EMISSION))
coal_plot <- coal_plot + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008 in the US') 

png(file = 'plot4.png', width = 480, height = 480 )
coal_plot
dev.off()
