#plot 1
#Total emissions from PM2.5 have decreased in the United States from 1999 to 2008

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggdata <- aggregate(NEI$Emissions, list(NEI$year), sum)
colnames(aggdata) <- c("Year","Emissions")

plot(aggdata$Year, aggdata$Emissions,
     type="o",
     col="blue",
     lwd=1,
     ylab="Total PM2.5 Emissions",
     xlab="Year",
     main="Total PM2.5 Emissions in the United States")

fitlinear<-lm(formula= aggdata$Emissions ~ aggdata$Year)
abline(fitlinear, lty="dashed")

dev.copy(png,"plot1.png")
dev.off()
