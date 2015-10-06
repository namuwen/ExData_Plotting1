library(dplyr)
# load file
data <- read.delim("household_power_consumption.txt", sep = ";", na.strings = "?") 
# add new datetime field
data <- mutate(data, DateTime = paste(Date,Time, sep = ' '))
# reformat date field
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")

# subset data
twodays <- data[data$Date %in% as.Date(c('2007-02-01','2007-02-02')),]

# create png file
png(file="plot4.png", width = 480, height = 480)

#create plot

par(mfrow = c(2,2))

plot(twodays$DateTime, twodays$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(twodays$DateTime,twodays$Voltage,ylab = "Voltage", xlab="datetime", type = "l")

plot(twodays$DateTime, twodays$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(twodays$DateTime, twodays$Sub_metering_2, type = "l", col = "red")
lines(twodays$DateTime, twodays$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col=c("black", "red", "blue"))

plot(twodays$DateTime,twodays$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab = "datetime")
dev.off()