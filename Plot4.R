# cargar archivo y guardar en variable "datos". 

datos <- read.table(file = "datos.txt", dec = "\t", sep = ";", header = T)



## trabajar solo con las fechas "1/2/2007" y "2/2/2007"


x <- subset(datos, Date== "1/2/2007" | Date== "2/2/2007")
str(x)


# Unir columna de Date y Time
fecha_h <- paste(x$Date, x$Time)


# convertir variable de Date/Time
fecha_h <- strptime(fecha_h, format = "%d/%m/%Y %H:%M:%S")

## Convertir demás variables a númericas
x$Global_active_power <- as.numeric(x$Global_active_power)
x$Global_reactive_power <- as.numeric(x$Global_reactive_power)
x$Voltage <- as.numeric(x$Voltage)
x$Global_intensity <- as.numeric(x$Global_intensity)
x$Sub_metering_1 <- as.numeric(x$Sub_metering_1)
x$Sub_metering_2<- as.numeric(x$Sub_metering_2)
x$Sub_metering_3 <- as.numeric(x$Sub_metering_3)


## unir variables

x <- cbind(x, fecha_h)

## Graficar PLOT 4

png(filename = 'Plot4.png')

par(mfrow = c(2,2), mar= c(4,4,2,1), oma= c(0,0,2,0))
plot(x$fecha_h, x$Global_active_power, type = "l",
     ylab = "Global Active Power (Kilowatts)", xlab = " ")
plot(x$fecha_h, x$Voltage, type = 'l', xlab = 'Datetime', ylab = 'Voltage')

with(x, plot(fecha_h, Sub_metering_1, type = "n", xlab = " ",
             ylab = "Energy sub metering"))

with(x, points(fecha_h, Sub_metering_1, col= " gray", type = "l", lwd=2))

with(x, points(fecha_h, Sub_metering_2, col= " red", type = "l", lwd=2))  

with(x, points(fecha_h, Sub_metering_3, col= " blue", type = "l", lwd=2))

legend("topright",lty = 1, lwd = 2, col= c("gray", "red","blue"), legend=
         c("sub_metering_1", "sub_metering_2", "sub_metering_3"), bty = 'n')

plot(x$fecha_h,  x$Global_reactive_power, ylab = 'Global_reactive_power', 
     xlab = 'Datetime',type = 'l')


dev.off()


