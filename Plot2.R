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




## Análisis en todos los días de la semana

png(filename = "Plot2.png")

plot(x$fecha_h, x$Global_active_power, type = "l",
     ylab = "Global Active Power (Kilowatts)", xlab = " ")

dev.off()


