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

#################### Plot 1 #############################

## Turn on png device and set parameters
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))

## plot hist
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Turn off device
dev.off()


