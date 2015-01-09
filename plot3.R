# Check if the data file exists, if not download it
# Helpfully provided, by one of the TAs in the forum
# https://class.coursera.org/exdata-010/forum/thread?thread_id=28#post-204
if (!file.exists("household_power_consumption.txt")){
  message("Downloading data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

# Read in the data
energy <- read.csv("household_power_consumption.txt", na.strings="?", dec=".", sep=";")

# Convert the date to Date format
energy$Date <- as.Date(energy$Date, "%d/%m/%Y")

# Then subset it for the two days we are interested in
# 2007-02-01 and 2007-02-02
energy.temp <- subset(energy, Date >= as.Date("2007-02-01"))
energy.sub <- subset(energy.temp, Date <= as.Date("2007-02-02"))

# Merge the date and time
energy.sub$DateTime <- as.POSIXct(paste(as.character(energy.sub$Date), as.character(energy.sub$Time)))

# Create the plot
png(file = "plot3.png", width = 480, height = 480)
plot(energy.sub$DateTime, energy.sub$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
points(energy.sub$DateTime, energy.sub$Sub_metering_1, type="l")
points(energy.sub$DateTime, energy.sub$Sub_metering_2, type="l", col="red")
points(energy.sub$DateTime, energy.sub$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



