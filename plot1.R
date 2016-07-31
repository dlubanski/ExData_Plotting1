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
gap <- dataDate$Global_active_power

#  Open PNG file device, write graph, close
png(filename = "plot1.png", width = 480, height = 480)
hist(gap, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()
