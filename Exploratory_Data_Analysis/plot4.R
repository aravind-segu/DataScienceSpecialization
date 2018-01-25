x <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
x$Date <- as.Date(x$Date, "%d/%m/%Y")
data <- subset(x, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$day <- weekdays(data$Date)

dateTime <- paste(data$Date, data$Time)
data$dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")

attach(data)
par(mfrow= c(2,2))
  plot(data$Global_active_power ~ data$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")

  plot(data$Voltage ~ data$dateTime, type = "l", ylab = "Voltage", xlab = "datetime")
  
  plot(data$Sub_metering_1~data$dateTime, type = "l",
    ylab="Global Active Power (kilowatts)", xlab = "")
  lines(data$Sub_metering_2~data$dateTime, col = 'Red')
  lines(data$Sub_metering_3~data$dateTime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1,
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$Global_reactive_power ~ data$dateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")