# ------------------ PLOT 4 ASSIGNMENT ---------------------------

# Cleaning up the environment
rm(list = ls())

# Working directory setup
getwd()
setwd('D:\\dev\\repo\\ExData_Plotting1')
getwd()

# Check if library is available, then use it...
find.package('data.table')
library(data.table)

# Reading of data (not including the missing data)
# (Prereq: Data in txt file already downloaded in the working directory)
powerConsumption <- data.table::fread(input = 'household_power_consumption.txt'
                                      , na.strings='?')

# Peak the head of the data
head(powerConsumption)


powerConsumption[, Date_and_Time := as.POSIXct(paste(Date, Time), 
                                               format = "%d/%m/%Y %H:%M:%S")]

# Check if the date format has changed
head(powerConsumption)

# Filter the dates from 2007-02-01 to 2007-02-03 only
powerConsumption <- powerConsumption[(Date_and_Time >= '2007-02-01') & 
                                         (Date_and_Time < '2007-02-03')]

# Check if the dimensions has changed after filtering
dim(powerConsumption)

# Check the structure
str(powerConsumption)

# Plot 4 (Graphics Device: PNG)
png('plot4.png', width = 480, height = 480)

# Create 2 Rows and 2 Column Layout
par(mfrow = c(2,2))

# Plot 1 (Graphics Device: Screen); Type: lines
# Reference is Plot2.R. Only change is the ylab --> 'kilowatts' is removed.
plot(x = powerConsumption$Date_and_Time,
     y = powerConsumption$Global_active_power, 
     type = 'l', 
     xlab = '', 
     ylab = 'Global Active Power')

# Plot 2 (Graphics Device: Screen); Type: lines
# New plot with Voltate as the Y axis.
plot(x = powerConsumption$Date_and_Time,
     y = powerConsumption$Voltage, 
     type = 'l', 
     xlab = 'datetime', 
     ylab = 'Voltage')


# Plot 3
# plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
# lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col="red")
# lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
# legend("topright", col=c("black","red","blue")
#        , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
#        , lty=c(1,1)
#        , bty="n"
#        , cex=.5) 

# Plot 3 (Graphics Device: Screen); Type: lines
# Reference: Plot3.R.
plot(x = powerConsumption$Date_and_Time, 
     y = powerConsumption$Sub_metering_1, 
     type = 'l', 
     xlab = '', 
     ylab = 'Energy sub metering')

lines(powerConsumption$Date_and_Time, 
      powerConsumption$Sub_metering_2,
      col = 'red')

lines(powerConsumption$Date_and_Time, 
      powerConsumption$Sub_metering_3,
      col = 'blue')

# Add legend
legend('topright', 
       col = c('black', 'red', 'blue'), 
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty = c(1,1), 
       lwd = c(1,1))

# Plot 4
plot(x = powerConsumption$Date_and_Time, 
     y = powerConsumption$Global_reactive_power, 
     type = 'l', 
     xlab = 'datetime', 
     ylab = 'Global_reactive_power', 
     lwd = c(1,1))

dev.off()