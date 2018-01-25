x <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
x$Date <- as.Date(x$Date, "%d/%m/%Y")
data <- subset(x, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$day <- weekdays(data$Date)

dateTime <- paste(data$Date, data$Time)
data$dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")
plot(data$Global_active_power ~ data$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")
dev.copy(png, file="plot2.png", height=480, width=480)