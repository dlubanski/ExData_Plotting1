#  This script requires that the input file is present in the working directory and
#  named "household_power_consumption.txt"
#  lubridate and data.table packages are also required

require(lubridate)
require(data.table)
filename <- "household_power_consumption.txt"

#  Load all data, we'll subset later
fullData <- fread(filename, sep = ";", header = TRUE, na.strings = "?")

#  Convert Date and time elements and create concatenated DateTime data
fullData$Date <- dmy(fullData$Date)

#  Subset data
dataDate <- subset(fullData, Date == dmy("01/02/2007") | Date == dmy("02/02/2007"))

dateTime <- paste(dataDate$Date, dataDate$Time, sep = " ")
dateTime <- ymd_hms(dateTime)

#  Extract data for graphics
meter1 <- as.numeric(dataDate$Sub_metering_1)
meter2 <- as.numeric(dataDate$Sub_metering_2)
meter3 <- as.numeric(dataDate$Sub_metering_3)

#  Open PNG file device, write graph, close
png(filename = "plot3.png", width = 480, height = 480)
plot(dateTime, meter1, type = "l", xlab = "", ylab = "Energy Sub Metering")
  lines(dateTime, meter2, type = "l", col = "red")
  lines(dateTime, meter3, type = "l", col = "blue")
  legend("topright", legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
         col = c("black","red","blue"), lty = 1, lwd = 2)
dev.off()
