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

##plot2
png(file="plot2.png",width=480,height=480)
with(myelecdata2,plot(MyDateTime,Global_active_power,type="l",col="black", xlab=" ", ylab="Global Active Power(kilowatts)"))
dev.off()
