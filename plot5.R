#plot5
#How emissions from Motor vehicle sources changed from 1999-2008 in Baltimore City

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_Motor <- SCC[grep("Motor",SCC$Short.Name, ignore.case = TRUE),]
SCC_Motor_IDs <- SCC_Motor$SCC
NEI_Motor <- subset(NEI,NEI$SCC %in% SCC_Motor_IDs)
NEI_Motor_Bal <- subset(NEI_Motor,NEI_Motor$fips=="24510")

aggdata_Motor_Bal <- aggregate(NEI_Motor_Bal$Emissions, list(NEI_Motor_Bal$year), sum)
colnames(aggdata_Motor_Bal) <- c("Year","Emissions")

plot(aggdata_Motor_Bal$Year, aggdata_Motor_Bal$Emissions,
     type="o",
     col="blue",
     lwd=1,
     ylab="Total PM2.5 Emissions",
     xlab="Year",
     main="Emissions from Motor Vehicle in Baltimore City")

dev.copy(png,"plot5.png")
dev.off()