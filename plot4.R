#plot4
#How emissions from coal combustion-related sources changed from 1999-2008

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal <- SCC[grep("coal",SCC$Short.Name, ignore.case = TRUE),]
SCC_coal_IDs <- SCC_coal$SCC
NEI_coal <- subset(NEI,NEI$SCC %in% SCC_coal_IDs)

aggdata_coal <- aggregate(NEI_coal$Emissions, list(NEI_coal$year), sum)
colnames(aggdata_coal) <- c("Year","Emissions")

plot(aggdata_coal$Year, aggdata_coal$Emissions,
     type="o",
     col="blue",
     lwd=1,
     ylab="Total PM2.5 Emissions",
     xlab="Year",
     main="Emissions for Coal Combustion in US")

fitlinear<-lm(formula= aggdata_coal$Emissions ~ aggdata_coal$Year)
abline(fitlinear, lty="dashed")

dev.copy(png,"plot4.png")
dev.off()