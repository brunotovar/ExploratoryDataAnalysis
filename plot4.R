# Read the file that should be in the working directory
dataset <-read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c(rep("character",2), rep("numeric",7)), na.strings="?")

# Filter the main dataset to create a small on that will be used for plot
datasetPlot <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007")

# Create a column that contains the complete date including day and time
datasetPlot$datetime<-as.POSIXct(strptime(paste(datasetPlot$Date,datasetPlot$Time, sep = " "), "%d/%m/%Y %H:%M:%S"))

# Plot the graph into a file and close device
png(file="plot4.png",width=480,height=480)

par(mfrow = c(2, 2))

# Create graph topleft
with(datasetPlot, plot(datetime, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l"))

# Create graph topright
with(datasetPlot, plot(datetime, Voltage, type="l"))

# Create graph bottomleft
with(datasetPlot, {
  plot(datetime, Sub_metering_1, col="black", ylab="Energy sub metering", xlab="", type="l")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
})

# Create graph bottomright
with(datasetPlot, plot(datetime, Global_reactive_power, type="l"))

dev.off()