
##### Project 1 for Exploratory Data Analysis ##############

################## Load and clean data #####################

## loading sqldf
library(sqldf)

## load household_power_consumption.txt file into data
file <- "./data/household_power_consumption.txt"
data <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")

## convert Date to type date
data[,1] <- as.Date(data[,1], "%d/%m/%Y")

## create a new column DateTime
data$DateTime <- paste(data$Date, data$Time)

## Convert DateTime column to proper format
data$DateTime <- strptime(data$DateTime, format="%Y-%m-%d %H:%M:%S")

#################### Plot 3 #############################

## Turn on png device and set parameters
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))

## Sets up the plot, but does not populate with any data
plot(data$DateTime, data$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")

## Plot line for sub_metering_1
lines(data$DateTime, data$Sub_metering_1, col = "black", type = "S")

## Plot line for sub_metering_2
lines(data$DateTime, data$Sub_metering_2, col = "red", type = "S")

## Plot line for sub_metering_3
lines(data$DateTime, data$Sub_metering_3, col = "blue", type = "S")

## Adds a legend with lines
## lwd = c(1, 1, 1) assigns the lines widths of 1
## lty = c(1, 1) assigns the line type within the legend
legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Turn off device
dev.off()

