library(data.table)
library(ggplot2)

#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

source_classification_code <- data.table(readRDS('Source_Classification_Code.rds'))
summarySCC_PM25 <- data.table(readRDS('summarySCC_PM25.rds'))

baltimore_LA <- summarySCC_PM25[fips == "24510" | fips == "06037"]
setkey(baltimore_LA, "year","fips")
vehicle_baltimore_LA <- baltimore_LA[type=='ON-ROAD', list(EMISSION=sum(Emissions)), by=key(baltimore_LA)]
compare_plot <- ggplot(data=vehicle_baltimore_LA , aes(x=as.character(year), y=EMISSION, fill=factor(fips,labels=c('Los Angeles County','Baltimore')))) +
  geom_bar(stat="identity",position=position_dodge()) +
  scale_fill_brewer(palette="Paired")+
  guides(fill=guide_legend(title="Location")) +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  labs(title = 'Total Emissions from motor vehicle sources \nFrom 1999 to 2008 \nIn Baltimore and Los Angeles County') + 
  theme(plot.title = element_text(hjust = 0.5))

png(file = 'plot6.png', width = 480, height = 480 )
compare_plot
dev.off()



