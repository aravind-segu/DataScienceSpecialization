x <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
x$Date <- as.Date(x$Date, "%d/%m/%Y")
data <- subset(x, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Gloabal Active Power")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
