#find lines that start with 1/2/2007 or 2/2/2007 to read in
start <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"))

#first line keeps column/variable names, store them for later use
columnnames <- strsplit(readLines("household_power_consumption.txt", n=1),";")

#read desired data (first and second of February 2007) in
subPower <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",skip=start[1]-1 ,nrows=length(start),col.names = columnnames[[1]])

#convert Date variable to date class
subPower$Date <- as.Date(strptime(subPower$Date, "%d/%m/%Y"))

#open png
png(file = "plot1.png", bg = "transparent")
#plot image
with(subPower,hist(Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts"))
#close png
dev.off()





