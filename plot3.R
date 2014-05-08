## Coursera Course
## Exploratory Data Analysis

rm(list=ls())
setwd("D:/Downloads/Coursera - Data Science/Exploratory Data Analysis/")


# load data
dat <- read.csv("household_power_consumption.txt", sep=";", na.strings=c("?","NA",""))
dat$datetime <- paste(dat$datetime, dat$Time)
dat$date <- NULL
dat$Time <- NULL
dat$datetime <- as.POSIXct(strptime(dat$datetime, format = "%d/%m/%Y %H:%M:%S"))

dat <- subset(dat, datetime >= as.POSIXct("2007-02-01") & datetime <= as.POSIXct("2007-02-02 23:59:59") )

#plot 
png("plot3.png")
plot(dat$datetime, dat$Sub_metering_1, type='l', ylab = 'Energy sub metering', xlab = "")
lines(dat$datetime, dat$Sub_metering_2, col = 'red' )
lines(dat$datetime, dat$Sub_metering_3, col = 'blue' )
legend("topright", lty = 1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()