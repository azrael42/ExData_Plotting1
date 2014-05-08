## Coursera Course
## Exploratory Data Analysis

rm(list=ls())
setwd("D:/Downloads/Coursera - Data Science/Exploratory Data Analysis/")


# load data
dat <- read.csv("household_power_consumption.txt", sep=";", na.strings=c("?","NA",""))
dat$datetime <- paste(dat$Date, dat$Time)
dat$Date <- NULL
dat$Time <- NULL
dat$datetime <- as.POSIXct(strptime(dat$datetime, format = "%d/%m/%Y %H:%M:%S"))

dat <- subset(dat, datetime >= as.POSIXct("2007-02-01") & datetime <= as.POSIXct("2007-02-02 23:59:59") )

#plot 
Sys.setlocale("LC_TIME","English")

png("plot2.png")
with(dat, plot(datetime, Global_active_power, type='l', ylab = 'Global Active Power (kilowatts)', xlab = ""))
dev.off()