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
png(file="plot3.png", width = 480, height = 480)

#create plot
plot(twodays$DateTime, twodays$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(twodays$DateTime, twodays$Sub_metering_2, type = "l", col = "red")
lines(twodays$DateTime, twodays$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()