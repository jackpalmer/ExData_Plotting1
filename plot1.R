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

# Plot histogram and save to png
png(file="plot1.png")
hist(df$Global_active_power, xlab ="Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()