#plot 2
#Total emissions from PM2.5 have decreased in the Baltimore City, Maryland from 1999 to 2008 
#however there was an increase of PM2.5 between the year 2002 and 2006.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Bal <- subset(NEI,NEI$fips=="24510")

aggdata_Bal <- aggregate(NEI_Bal$Emissions, list(NEI_Bal$year), sum)
colnames(aggdata_Bal) <- c("Year","Emissions")

plot(aggdata_Bal$Year, aggdata_Bal$Emissions,
     type="o",
     col="blue",
     lwd=1,
     ylab="Total PM2.5 Emissions",
     xlab="Year",
     main="Total PM2.5 Emissions in Baltimore City")

dev.copy(png,"plot2.png")
dev.off()
