x <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
x$Date <- as.Date(x$Date, "%d/%m/%Y")
data <- subset(x, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$day <- weekdays(data$Date)

dateTime <- paste(data$Date, data$Time)
data$dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")

with(data, {
  plot(Sub_metering_1~dateTime, type = "l",
       ylab="Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~dateTime, col = 'Red')
  lines(Sub_metering_3~dateTime, col = 'Blue')
})

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))