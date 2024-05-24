library(terra) 
library(imageRy)

setwd("C:/Users/anisz/Downloads") #we explain to the system in which folder of my PC it has to extract the data we want to import 

#importing images
t07 <- rast("Tenerife_luglio.jpg") #this function creates SpatRaster objects; we load in R the image of Tenerife before the fire
t07 #asking for the info about the images: the bands ecc
plot(t07) #to see the image
t09 <- rast("Tenerife_settembre.jpg") #loading the image of the island after one month of fire
t09 #asking for the info about the images: the bands ecc

#multiframe of natural colors to see the differences
par(mfrow=c(1,2))
plot(t07)
plot(t09)

#fin qua allenamento ma non so quanto senso abbia

