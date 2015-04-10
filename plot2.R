#find lines that start with 1/2/2007 or 2/2/2007 to read in
start <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"))

#first line keeps column/variable names, store them for later use
columnnames <- strsplit(readLines("household_power_consumption.txt", n=1),";")

#read desired data (first and second of February 2007) in
subPower <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",skip=start[1]-1 ,nrows=length(start),col.names = columnnames[[1]])

#convert Date and Time variable to one date class
subPower$DateTime <- as.POSIXct(paste(subPower$Date, subPower$Time), format="%d/%m/%Y %H:%M:%S")


#open png
png(file = "plot2.png", bg = "transparent")
#plot image
with(subPower,plot(DateTime,Global_active_power, type="l",main=NULL,xlab="",ylab="Global Active Power (kilowatts)"))
#close png
dev.off()
