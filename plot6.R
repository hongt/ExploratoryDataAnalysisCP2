#plot6
#Motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#have decreased compare to Los Angeles County, California.The city which has seen greater 
#changes over time in motor vehicle emissions is Los Angeles Country.

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_Motor<- SCC[grep("motor",SCC$Short.Name, ignore.case = TRUE),]
SCC_Motor_IDs <- SCC_Motor$SCC
NEI_Motor <- subset(NEI,NEI$SCC %in% SCC_Motor_IDs)
NEI_Motor_Bal <- subset(NEI_Motor,NEI_Motor$fips=="24510")
NEI_Motor_LA <- subset(NEI_Motor,NEI_Motor$fips=="06037")

aggdata_Motor_Bal <- aggregate(NEI_Motor_Bal$Emissions, list(NEI_Motor_Bal$year), sum)
colnames(aggdata_Motor_Bal) <- c("Year","Emissions")
aggdata_Motor_Bal["City"] <- NA
aggdata_Motor_Bal$City <- c("Baltimore City")

aggdata_Motor_LA <- aggregate(NEI_Motor_LA$Emissions, list(NEI_Motor_LA$year), sum)
colnames(aggdata_Motor_LA) <- c("Year","Emissions")
aggdata_Motor_LA["City"] <- NA
aggdata_Motor_LA$City <- c("Los Angeles Country")

aggdata_Motor_City <- rbind(aggdata_Motor_Bal,aggdata_Motor_LA)

ggplot(aggdata_Motor_City, aes(x=Year, y=Emissions, color=City)) + geom_line() + geom_point() + 
  labs(color = "City", x = "Year", y = "Total PM2.5 Emissions") +
  ggtitle("Emissions from Motor Vehicle in Baltimore & Los Angeles")

dev.copy(png,"plot6.png")
dev.off()