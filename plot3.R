library("data.table")


#Reads in data 
hpc <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")

# Prevents Scientific Notation
hpc[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
hpc[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Filter Dates 2007-02-01 and 20017-02-02
hpc[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
hpc <- hpc[(Date >= "2007/02/01") & (Date < "2007/02/03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(hpc[, dateTime], hpc[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(hpc[, dateTime], hpc[, Sub_metering_2],col="red")
lines(hpc[, dateTime], hpc[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()