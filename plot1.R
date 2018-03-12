# ------------------ PLOT 1 ASSIGNMENT ---------------------------

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

# Convert the Date variables to Date Class/Format
powerConsumption[, Date := lapply(.SD, as.Date, '%d/%m/%Y'), 
    .SDcols = c('Date')]

powerConsumption[, Time := lapply(.SD, 
                                  function(x) as.POSIXct(strptime(x, '%H:%M:%S'))), 
                                .SDcols = c('Time')]

# Warning message:
#     In strptime(x, "%H:%M:%S") :
#     POSIXlt column type detected and converted to POSIXct. We do not recommend use of POSIXlt at all because it uses 40 bytes to store one date.

# Check if the date format has changed
head(powerConsumption)

# Filter the dates from 2007-02-01 to 2007-02-02 only
powerConsumption <- powerConsumption[(Date >= '2007-02-01') & 
    (Date <= '2007-02-02')]

# Check if the dimensions has changed after filtering
dim(powerConsumption)

# Check the structure
str(powerConsumption)

# Plot 1 (Graphics Device: PNG)
png("plot1.png", width=480, height=480)

# Plot 1 (Graphics Device: Screen)
hist(powerConsumption$Global_active_power, main='Global Active Power', 
     xlab='Global Active Power (kilowatts)', ylab='Frequency', col='red')

rug(powerConsumption$Global_active_power)

dev.off()