##Reading the table after pasting the text file in the working directory obtained frm getwd()
tab <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##Cleaning the data
##Formatting the date to Type Date
 tab$Date <- as.Date(tab$Date, "%d/%m/%Y")

## Filtering the data set from Feb. 1, 2007 to Feb. 2, 2007
 tab <- subset(tab,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Removing the incomplete observation
 tab <- tab[complete.cases(tab),]

## Combining Date and Time column
 dateTime <- paste(tab$Date, tab$Time)
 dateTime <- setNames(dateTime, "DateTime")

## Removing Date and Time column
 tab <- tab[ ,!(names(tab) %in% c("Date","Time"))]

## Adding DateTime column
 tab <- cbind(dateTime, tab)

## Formatting dateTime Column
 tab$dateTime <- as.POSIXct(dateTime)

##Plotting histogram
hist(tab$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()