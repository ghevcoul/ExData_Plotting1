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

# Create the plot
png(file = "plot1.png", width = 480, height = 480)
hist(energy.sub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()



