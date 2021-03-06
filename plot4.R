# Load data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep =";",na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
)
unlink(temp)

# Format date
data$Date <- as.Date(strptime(data$Date,format = "%d/%m/%Y"))

# Subset to specified period
df <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Create datetime field
df$datetime <- strptime(paste(df$Date,df$Time,sep = " "),format = "%Y-%m-%d %H:%M:%S")

# Plot and output to PNG
png(file="plot4.png")
par(mfrow = c(2,2))
{
  with(df, plot(datetime,Global_active_power,type = "l", xlab = "", ylab = "Global Active Power"))
  with(df, plot(datetime,Voltage,type = "l", xlab = "datetime", ylab = "Voltage"))
  with(df, plot(datetime,Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering"))
    with(df, lines(datetime,Sub_metering_2, col = "red"))
    with(df, lines(datetime,Sub_metering_3, col = "blue"))
    legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
  with(df, plot(datetime,Global_reactive_power,type = "l"))
}
dev.off()