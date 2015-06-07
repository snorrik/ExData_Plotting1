#Please, first set up a right working directory! Thanks.

# a file to get data
  f <- "household_power_consumption.txt"
  
# use a sql select to get correct dates
  library(sqldf)
  selector <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  
  #read the table the selector
  powerData <- read.csv.sql(f, sql=selector, sep=";")
  
  #read in data convert date and time columns
  powerData$DateTime <- as.POSIXct(strptime(paste(powerData$Date,powerData$Time), "%d/%m/%Y %H:%M:%S"))
  
 
 powd <- powerData

# If your language is not English, change language
  Sys.setlocale("LC_TIME", "English")

#open png graphics device
png(filename = "plot4.png", width = 480, height = 480)
  
  #Graphs will be in two columns and two rows
  par(mfrow=c(2,2))
  
  #plot a graph 1
  plot(powd$DateTime, powd$Global_active_power, type="l", 
       ylab ="Global Active Power", xlab ="", col = "black")
  
  #plot a graph 2
  plot(powd$DateTime, powd$Voltage, type="l", 
       ylab ="Voltage", xlab ="datetime", col = "black")

  #plot a graph 3
plot(powd$DateTime, powd$Sub_metering_1, type="l", 
     ylab ="Energy sub metering", xlab ="", col = "black")
  lines(powd$DateTime, powd$Sub_metering_2, type="l", 
        col = "red")
  lines(powd$DateTime, powd$Sub_metering_3, type="l", 
         col = "blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
         col=c("black","blue","red"), bty = "n", lty=c(1,1,1),lwd=c(2.5,2.5,2.5))
  
  #plot a graph 4
  plot(powd$DateTime, powd$Global_reactive_power, type="l", 
       ylab ="Global_reactive_power", xlab ="datetime", col = "black")
  # close graphics device
dev.off()
