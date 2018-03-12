# ------------------ PLOT 3 ASSIGNMENT ---------------------------

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

# Plot 3 (Graphics Device: PNG)
png('plot3.png', width = 480, height = 480)

# Plot 3 (Graphics Device: Screen); Type: lines
# No X label as shown in the reference image.
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

dev.off()