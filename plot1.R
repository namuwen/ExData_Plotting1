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
png(file="plot1.png", width = 480, height = 480)

#create plot
hist(twodays$Global_active_power, xlab = "Global Active Power (Kilowatts", main = "Global Active Power", col = "red")
dev.off()