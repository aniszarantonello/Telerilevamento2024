## The aim of the project is to calculate the area damaged by the fire that affected Tenerife island from the 15th till the 30th of august 2023.
# Data taken from Copernicus Browser

#first of all we recall all the packages we need 
library(terra) 
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

#we set the working directory
setwd("C:/Users/anisz/Downloads") #we explain to the system in which folder of my PC it has to extract the data we want to import 

## We calculate the NBR index, a standard for fire severity assessment, which is used to highlight burned areas in large fire zones.
## We first calculate it for july and then for september.

cl.tn <- colorRampPalette(c("yellow", "slateblue", "wheat4")) (100)

## july NBR
july <- rast("luglio_swir.jpg")
# 1 = B12 = SWIR
# 2 = B8 = NIR
# 3 = B4 = red

plot(july[[1]], col = cl.tn)  #swir: absorbed by vegetation
plot(july[[2]], col= cl.tn)  #nir: reflected by vegetation

diff.july = july[[2]] - july[[1]] 
plot(diff.july, col = cl.tn)
sum.july = july[[1]] + july[[2]]
plot(sum.july, col = cl.tn)
NBR_july = (diff.july) / (sum.july)

viridis <- colorRampPalette(viridis(7))(255) #recall package viridis
plot(NBR_july, col = viridis) # we use viridis to enhance differences

## september NBR
sept <- rast("settembre_swir.jpg")
plot(sept[[1]], col = cl.tn) #swir
plot(sept[[2]], col= cl.tn) #nir
diff.sept = sept[[2]] - sept[[1]]
plot(diff.sept, col = cl.tn)
sum.sept = sept[[1]] + sept[[2]]
plot(sum.sept, col = cl.tn)
NBR_sept = (diff.sept) / (sum.sept)

plot(NBR_sept, col = viridis)

#we put them on a stack
NBRstack <- c(NBR_july, NBR_sept)
names(NBR_stack) <- c("NBR july", "NBR september")
plot(NBR_stack, col = viridis)
#non funziona

#dNBR or delta NBR can be used to estimate the burn severity. is the difference between the pre-fire and post-fire NBR 
dNBR = (NBR_july) - (NBR_sept)
plot(dNBRtn, col = viridis)
#non funziona




#####da rivedere cosa classificare
# Now we classify the land cover to see the differences between July and September
#importing false color images:
july2 <- rast("luglio_falsecolor.jpg")
sept2 <- rast("settembre_falsecolor.jpg")
# band 1 = nir = R
# band 2 = red = G
# band 3 = green = B

#classification: #quantiffying fire cover 
julyc <- im.classify(july2, num_cluster = 3)
#class 1 = forest #questi cambiano ogni volta quindi da rivedere 
#class 2 = human and fire modification
#class 3 = sea and desert
septc <- im.classify(sept2, num_cluster = 3)
#class 1 = forest
#class 2 = human and fire modification
#class 3 = sea and desert

##potrei anche calcolare la variability



#########################




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

#importing data: single bands
setwd("C:/Users/anisz/Downloads") #we explain to the system in which folder of my PC it has to extract the data we want to import 

B02luglio <- rast("B02_luglio.jpg") #--> blue
B03luglio <- rast("B03_luglio.jpg") #--> green
B04luglio <- rast("B04_luglio.jpg") #--> red
B08luglio <- rast("B08_luglio.jpg") #--> nir
B02settembre <- rast("B02_settembre.jpg") #--> blue
B03settembre <- rast("B03_settembre.jpg") #--> green
B04settembre <- rast("B04_settembre.jpg") #--> red
B08settembre <- rast("B08_settembre.jpg") #--> nir

#stacksent luglio
vir <- colorRampPalette(viridis(7)) (256)
stacksent <- c(B02luglio, B03luglio, B04luglio, B08luglio) 
plot(stacksent, col = vir)

#RGB plotting
#stacksent[[1]] = b2 = blue
#stacksent[[2]] = b3 = green
#stacksent[[3]] = b4 = red
#stacksent[[4]] = b8 = nir 
par(mfrow = c(2,2)) #let's create a multiframe to see nir in every band
im.plotRGB(stacksent, 3, 2, 1) #natural color
im.plotRGB(stacksent, 4, 3, 2) #nir on red
im.plotRGB(stacksent, 3, 4, 2) #nir on green
im.plotRGB(stacksent, 3, 2, 4) #nir on blue

#stacksent settembre
vir <- colorRampPalette(viridis(7)) (256)
stacksent2 <- c(B02settembre, B03settembre, B04settembre, B08settembre) 
plot(stacksent2, col = vir)

#RGB plotting
#stacksent2[[1]] = b2 = blue
#stacksent2[[2]] = b3 = green
#stacksent2[[3]] = b4 = red
#stacksent2[[4]] = b8 = nir 
par(mfrow = c(2,2))
im.plotRGB(stacksent2, 3, 2, 1) #natural color
im.plotRGB(stacksent2, 4, 3, 2) #nir on red
im.plotRGB(stacksent2, 3, 4, 2) #nir on green
im.plotRGB(stacksent2, 3, 2, 4) #nir on blue

#differenza luglio-settembre
par(mfrow = c(1,2))
plot(B08luglio, col = vir)
plot(B08settembre, col = vir)

#confronto tra nir
par(mfrow = c(1,2))
im.plotRGB(stacksent, 4, 3, 2) #nir on red in july
im.plotRGB(stacksent2, 4, 3, 2) #nir on red in september #we see a clearly difference


#importing false color images:
luglio <- rast("luglio_falsecolor.jpg")
settembre <- rast("settembre_falsecolor.jpg")

# band 1 = nir = R
# band 2 = red = G
# band 3 = green = B

par(mfrow = c(2,3)) #2 rows and 3 columns where rows refers to july and september, and in columns there is the nir in the various bands
#now we load all images 
im.plotRGB(luglio, 1, 2, 3) #nir on red
im.plotRGB(luglio, 2, 1, 3) #nir on green
im.plotRGB(luglio, 2, 3, 1) #nir on blue
im.plotRGB(settembre, 1, 2, 3) #nir on red
im.plotRGB(settembre, 2, 1, 3) #nir on green
im.plotRGB(settembre, 2, 3, 1) #nir on blue

#Calculating the DVI (Difference Vegetation Index)
#band 1 = nir
#band 2 = red
dviluglio = luglio[[1]] - luglio[[2]] 
plot(dviluglio, col = vir)

dvisettembre = settembre[[1]] - settembre[[2]] 
plot(dvisettembre, col = vir)

par(mfrow = c(1,2))
plot(dviluglio, col = vir)
plot(dvisettembre, col = vir)

#NDVI
ndviluglio = dviluglio/(luglio[[1]] + luglio[[2]])
ndvisettembre = dvisettembre/(settembre[[1]] + settembre[[2]])
par(mfrow = c(1,2))
plot(ndviluglio, col = vir)
plot(ndvisettembre, col = vir)

#classification: #quantiffying fire cover 
julyc <- im.classify(luglio, num_cluster = 3)
#class 1 = forest #questi cambiano ogni volta quindi da rivedere 
#class 2 = human and fire modification
#class 3 = sea and desert
septc <- im.classify(settembre, num_cluster = 3)
#class 1 = forest
#class 2 = human and fire modification
#class 3 = sea and desert

#calculating frequencies
freqluglio <- freq(lclassy) #the response of R will be the count of pixels organized in the two classes
#proportions
totluglio <- ncell(lclassy) #this is the total number of pixels
propluglio = freqluglio / totluglio #is a proportion between the frequences and the total
#percentages
percluglio = propluglio * 100 

#we do the same for september
freqsettembre <- freq(sclassy) #the response of R will be the count of pixels organized in the two classes
#proportions
totsettembre <- ncell(sclassy) #this is the total number of pixels
propsettembre = freqsettembre / totsettembre #is a proportion between the frequences and the total
#percentages
percsettembre = propsettembre * 100 


#MANCA LA PARTE DEI PLOT MA FALLO LA VOLTA DEFINITIVA DATO CHE OGNI VOLTA TI CAMBIA LE CLASSI

