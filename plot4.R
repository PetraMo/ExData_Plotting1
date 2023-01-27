library(dplyr)
##download & prepare data
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              destfile = './C4w1_Elec.zip', method = 'curl', quiet = T)
unzip(zipfile ='./C4w1_Elec.zip')
elecdata <- read.table('./household_power_consumption.txt', na.strings="?",sep=";",header=TRUE)
dateDownloaded<-date()
myelecdata<-filter(elecdata,as.Date(Date, format="%d/%m/%Y")==as.Date("1/2/2007","%d/%m/%Y")|
                     as.Date(Date, format="%d/%m/%Y")==as.Date("2/2/2007","%d/%m/%Y"))
myelecdata2<-mutate(myelecdata,MyDateTime=as.POSIXct(paste(Date,Time, sep=" " ),format = "%d/%m/%Y %H:%M:%S", tz = "America/New_York"))

##plot4
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2),mar=c(4,4,2,1),oma=c(0,0,0,0))
with(myelecdata2,{
  plot(MyDateTime,Global_active_power,type="l",col="black", ylab="Global Active Power(kilowatts)")
  
  plot(MyDateTime,Sub_metering_1,type="l",col="black",ylab="Energy submetering",xlab=" ")
  lines(MyDateTime,Sub_metering_2,type="l",col="red")
  lines(MyDateTime,Sub_metering_3,type="l",col="blue" ) 
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),box.lwd = 1)
  
  plot(MyDateTime,Voltage,type="l",col="black", ylab="Voltage",xlab="datetime")
  
  plot(MyDateTime,Global_reactive_power,type="l",col="black", ylab="Global_reactive_power",xlab="datetime")
})
dev.off()
graphics.off()
