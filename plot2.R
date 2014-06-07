#############################################################################
## File name: plot2.R
## 
## Date: June 6, 2014
#############################################################################

## Notes: On my Windows machines, I have to tell R to make use of the ‘internet2.dll’ 
## library for Internet access.
setInternet2()

## Download the dataset from internet URL site
urlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(urlfile, destfile)

## Unzipped the downloaded data file
unzippedFile <- unzip(destfile, "household_power_consumption.txt")
## unz reading a zip file without unzipping - unz is faster than unzip
# unzippedFile <- unz(destfile, "household_power_consumption.txt")

## Read in the dataset as a table
tbl <- read.table(unzippedFile, header = TRUE, sep = ';', na.strings ="?", 
                  colClasses = c("character","character","numeric","numeric",
				                 "numeric","numeric","numeric","numeric","numeric"))

## Examine how household energy usage varies over a 2-day period in February, 2007
tbl <- tbl[(tbl$Date == "1/2/2007") | (tbl$Date == "2/2/2007"),]
## Convert the Date and Time variables to Date/Time classes
tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time), "%d/%m/%Y %H:%M:%S")

## Construct the "plot2.png" plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(tbl$DateTime, tbl$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## Also create the plot on screen for visual validation
plot(tbl$DateTime, tbl$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## To test plot2.R
# > source("plot2.R")
## Or, cut and paste the code in this file to run on R Console
