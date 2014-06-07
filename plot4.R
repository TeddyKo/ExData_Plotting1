#############################################################################
## File name: plot4.R
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

## Construct the "plot4.png" plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
old.par <- par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
    plot(tbl$DateTime, tbl$Global_active_power, xlab="", ylab="Global Active Power", type="l")
    plot(tbl$DateTime, tbl$Voltage, xlab="datetime", ylab="Voltage", type="l")
    cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    plot(tbl$DateTime, tbl$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(tbl$DateTime, tbl$Sub_metering_2, type="l", col="red")
    lines(tbl$DateTime, tbl$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black","red","blue"), legend=cols, bty="n")
    plot(tbl$DateTime, tbl$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")        
dev.off()
## Reset the graphical parameters back to what they were originally
par(old.par)

## Also create the plot on screen for visual validation
old.par <- par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
    plot(tbl$DateTime, tbl$Global_active_power, xlab="", ylab="Global Active Power", type="l")
    plot(tbl$DateTime, tbl$Voltage, xlab="datetime", ylab="Voltage", type="l")
    cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    plot(tbl$DateTime, tbl$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(tbl$DateTime, tbl$Sub_metering_2, type="l", col="red")
    lines(tbl$DateTime, tbl$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black","red","blue"), legend=cols, bty="n")
    plot(tbl$DateTime, tbl$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")        
## Reset the graphical parameters back to what they were originally
par(old.par)

## To test plot4.R
# > source("plot4.R")
## Or, cut and paste the code in this file to run on R Console
