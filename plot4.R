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

#################### Plot 4 #############################

## Turn on png device and set parameters
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(6, 6, 5, 4), cex=.5)

## Plot in top left
## Sets up the plot, but does not plot with point
## type = "n" builds plots without points
## xaxt = NULL suppresses x axis
## xlab = "" removes the label from the x axis
## otherwise, the axis is the name of the x variable, which is date_time
plot(data$DateTime, data$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")

## plot line
lines(data$DateTime, data$Global_active_power, type="S")

## plot top right graph
## type = "n" builds plots without points
## xaxt = NULL suppresses x axis
plot(data$DateTime, data$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")

## plot line
lines(data$DateTime, data$Voltage, type="S")

## Plot in bottom left
## Sets up the plot, but does not plot with point
plot(data$DateTime, data$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")

## Plots line for sub_metering_1
lines(data$DateTime, data$Sub_metering_1, col = "black", type = "S")

## Plots line for sub_metering_2
lines(data$DateTime, data$Sub_metering_2, col = "red", type = "S")

## Plots line for sub_metering_3
lines(data$DateTime, data$Sub_metering_3, col = "blue", type = "S")

## Adds a legend with lines
## lwd = c(1, 1, 1) assigns the lines widths of 1
## lty = c(1, 1) assigns the line type within the legend
## bty = "n" sets the box type to none
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## plot bottom right graph
## type = "n" builds plots without points
## xaxt = NULL suppresses x axis
plot(data$DateTime, data$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")

## plot line
lines(data$DateTime, data$Global_reactive_power, type="S")

## Turn off device
dev.off()