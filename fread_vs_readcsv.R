## Coursera Course
## Exploratory Data Analysis

rm(list=ls())
setwd("D:/Downloads/Coursera - Data Science/Exploratory Data Analysis/")

system.time( { 
  dat <- read.csv("household_power_consumption.txt", sep=";", na.strings=c("?","NA",""))
})
# User 16 seconds 

system.time( {  
  dat$datetime <- paste(dat$Date, dat$Time)
  dat$Date <- NULL
  dat$Time <- NULL
  dat$datetime <- as.POSIXct(strptime(dat$datetime, format = "%d/%m/%Y %H:%M:%S"))

  dat1 <- subset(dat, datetime >= as.POSIXct("2007-02-01") & datetime <= as.POSIXct("2007-02-02 23:59:59") )
} )
# User 60 seconds 

library(data.table)

system.time( {  
  # colClasses character prevents lengthy warnings
  # fread's na.strings does not work smoothly yet: ? are transformed into NAs, but only after 
  # auto-transforming the numeric columns to character columns.
  dat <- fread("household_power_consumption.txt", na.strings=c("?","NA",""), 
                            colClasses = rep("character",9), verbose = F)
  dat[, 3:9 := lapply(.SD, as.numeric), .SDcols = 3:9]
})
# User 5 seconds

system.time( {    
  dat[,datetime:=paste(Date,Time)]
  dat[,Date:=NULL]
  dat[,Time:=NULL]
  dat[,datetime:= as.POSIXct(strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))]
  
  setkey(dat,datetime)
  dat2 <- dat[datetime>=as.POSIXct("2007-02-01") & datetime <= as.POSIXct("2007-02-02 23:59:59"), ] 
})
# User 51s

dat1 <- data.table(dat1)
setkey(dat1,datetime)
tables()
all.equal(dat1,dat2)
identical(dat1,dat2)

dat <- dat1

save(dat, file = "Housefold_relevant_subset.RData")



