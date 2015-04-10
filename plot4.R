#find lines that start with 1/2/2007 or 2/2/2007 to read in
start <- grep("^[1-2]/2/2007", readLines("household_power_consumption.txt"))

#first line keeps column/variable names, store them for later use
columnnames <- strsplit(readLines("household_power_consumption.txt", n=1),";")

#read desired data (first and second of February 2007) in
subPower <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",skip=start[1]-1 ,nrows=length(start),col.names = columnnames[[1]])

#convert Date and Time variable to one date class
subPower$DateTime <- as.POSIXct(paste(subPower$Date, subPower$Time), format="%d/%m/%Y %H:%M:%S")


#open png
png(file = "plot4.png", bg = "transparent")
#Set grid and font size
par(mfrow=c(2,2),cex=0.7)
#plot first graph
with(subPower,hist(Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts"))
#plot second graph
with(subPower,plot(DateTime,Voltage, type="l",main=NULL,ylab="Voltage"))
#plot third graph
with(subPower,plot(DateTime,Sub_metering_1, type="n",main=NULL,xlab="",ylab="Energy Sub Metering"))
lines(subPower$DateTime,subPower$Sub_metering_1)
lines(subPower$DateTime,subPower$Sub_metering_2, col="red")
lines(subPower$DateTime,subPower$Sub_metering_3, col="blue")
legend("topright", lty=1,lwd=1,col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#plot fourth graph
with(subPower,plot(DateTime,Global_active_power, type="l",main=NULL,ylab="Global Active Power (kilowatts)"))

#close png
dev.off()
