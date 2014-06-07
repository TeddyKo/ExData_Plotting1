#############################################################################
## File name: plot1.R
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

## Construct the "plot1.png" plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(tbl$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

## Also create the plot on screen for visual validation
hist(tbl$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

## To test plot1.R
# > source("plot1.R")
## Or, cut and paste the code in this file to run on R Console