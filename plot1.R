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

#open png graphics device
png(filename = "plot1.png", width = 480, height = 480)

  #plot a histogram
hist(powd$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (Killowats)",col="red",ylim=c(0,1200))
  # close graphics device
dev.off()
