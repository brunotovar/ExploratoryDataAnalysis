# Read the file that should be in the working directory
dataset <-read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c(rep("character",2), rep("numeric",7)), na.strings="?")

# Filter the main dataset to create a small on that will be used for plot
datasetPlot <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007")

# Create a column that contains the complete date including day and time
datasetPlot$datetime<-as.POSIXct(strptime(paste(datasetPlot$Date,datasetPlot$Time, sep = " "), "%d/%m/%Y %H:%M:%S"))

# Plot the graph into a file and close device
png(file="plot1.png",width=480,height=480)
hist(datasetPlot$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()