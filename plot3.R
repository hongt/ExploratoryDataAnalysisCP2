#plot 3
#Type NONPOINT,NON-ROAD,ON-ROAD have seen decreases in emissions from 1999-2008 for Baltimore City 
#Type POINT has seen increases in emissions from 1999-2005 and decreases from 2005-2008

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Bal <- subset(NEI,NEI$fips=="24510")
aggdata_Bal_Type <- aggregate(NEI_Bal$Emissions, list(NEI_Bal$type, NEI_Bal$year), sum)
colnames(aggdata_Bal_Type) <- c("Type","Year","Emissions")

ggplot(aggdata_Bal_Type, aes(x=Year, y=Emissions, color=Type)) + geom_line() + geom_point() + 
  labs(color = "Pollutant Type", x = "Year", y = "Total PM2.5 Emissions") +
  ggtitle("Total PM2.5 Emissions by Pollutant Type in Baltimore City")

dev.copy(png,"plot3.png")
dev.off()
