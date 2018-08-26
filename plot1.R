library(data.table)

#Read Data from the file.

hpc <- data.table::fread(input = "household_power_consumption.txt",na.strings = "?")

hpc[,Global_active_power := lapply(.SD,as.numeric), .SDcols = c("Global_active_power")]

# Change date type
hpc[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Filter Dates 2007-02-01 and 20017-02-02

hpc<-hpc[(Date >= "2007-02-01") & (Date <= "2007-02-02")]


#hist(hpc[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")


## Plot 1
png("plot1.png", width=480, height=480)
hist(hpc[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
