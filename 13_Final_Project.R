## The aim of the project is calculate the area damaged by the fire that affected Tenerife island from the 15th till the 30th of august 2023.
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

#loading images
july <- rast("luglio_swir.jpg")
sept <- rast("settembre_swir.jpg")
# 1 = B12 = SWIR
# 2 = B8 = NIR
# 3 = B4 = red
par(mfrow = c(1,2)) 
plot(july)
plot(sept)

dev.off()

## july NBR
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
names(NBRstack) <- c("NBR july", "NBR september")
plot(NBRstack, col = viridis)

#dNBR or delta NBR can be used to estimate the burn severity. is the difference between the pre-fire and post-fire NBR 
dNBR = (NBR_july) - (NBR_sept)
plot(dNBR, col = viridis)

########
#Now we zoom to the region that has been more damaged from the wildfire, we take a square of 13x13km
#we calculate the NBR
#we do the classification

julyB <- rast("zona1_luglio_swir.jpg")
plot(julyB)
septB <- rast("zona1_sett_swir.jpg")
plot(septB)

par(mfrow = c(1,2)) 
plot(julyB)
plot(septB)

dev.off()

## julyB NBR
plot(julyB[[1]], col = cl.tn)  #swir: absorbed by vegetation
plot(julyB[[2]], col= cl.tn)  #nir: reflected by vegetation

diff.julyB = julyB[[2]] - julyB[[1]] 
plot(diff.julyB, col = cl.tn)
sum.julyB = julyB[[1]] + julyB[[2]]
plot(sum.julyB, col = cl.tn)
NBR_julyB = (diff.julyB) / (sum.julyB)

viridis <- colorRampPalette(viridis(7))(255) #recall package viridis
plot(NBR_julyB, col = viridis) # we use viridis to enhance differences

## septemberB NBR
plot(septB[[1]], col = cl.tn) #swir
plot(septB[[2]], col= cl.tn) #nir
diff.septB = septB[[2]] - septB[[1]]
plot(diff.septB, col = cl.tn)
sum.septB = septB[[1]] + septB[[2]]
plot(sum.septB, col = cl.tn)
NBR_septB = (diff.septB) / (sum.septB)

plot(NBR_septB, col = viridis)

NBRstack2 <- c(NBR_julyB, NBR_septB)
names(NBRstack2) <- c("NBR july", "NBR september")
plot(NBRstack2, col = viridis)

#dNBR or delta NBR can be used to estimate the burn severity. is the difference between the pre-fire and post-fire NBR 
dNBR2 = (NBR_julyB) - (NBR_septB)
plot(dNBR2, col = viridis)
#A higher value of dNBR indicates more severe damage;
#Areas with negative dNBR values may indicate regrowth following a fire.

#now we try yo do a classification on the dNBR to calculate the area damaged
damaged_area <- im.classify(dNBR2, num_cluster = 3)
#1 is no damaged
#2 is damaged a bit
#3 is extremly damaged

#calculating frequencies
freqdNBR2 <- freq(damaged_area) #the response of R will be the count of pixels organized in the two classes
freqdNBR2
#1 = 1050714
#2 = 535256
#3 = 195238

#calculating proportions
totdNBR2 <- ncell(dNBR2) #this is the total number of pixels
totdNBR2 #1781208
propdNBR2 = freqdNBR2 / totdNBR2 #is a proportion between the frequencies and the total
propdNBR2

#calculatingpercentages
percdNBR2 = propdNBR2 * 100 
percdNBR2
#1 = 59%
#2 = 30%
#3 = 11%

###
plot(NBR_julyB, col = viridis) # we use viridis to enhance differences
plot(NBR_septB, col = viridis)

NBRluglio_c <- im.classify(NBR_julyB, num_clusters = 2)
NBRsett_c <- im.classify(NBR_septB, num_clusters = 2)
#1 no vegetation, means fire
#2 is vegetation

##calculating frequencies, proportions and percentages for july
freqluglio <- freq(NBRluglio_c) #the response of R will be the count of pixels organized in the two classes
freqluglio
#1 = 853151
#2 = 928057

totluglio <- ncell(NBR_julyB) #this is the total number of pixels
totluglio #1781208
propluglio = freqluglio / totluglio #is a proportion between the frequencies and the total
propluglio

percluglio = propluglio * 100 
percluglio
#1 = 47%
#2 = 52%

##calculating frequencies, proportions and percentages for september
freqsett <- freq(NBRsett_c) #the response of R will be the count of pixels organized in the two classes
freqsett
#1 = 1148406
#2 = 632802

totsett <- ncell(NBR_septB) #this is the total number of pixels
totsett #1781208
propsett = freqsett / totsett #is a proportion between the frequencies and the total
propsett

percsett = propsett * 100 
percsett
#1 = 64%
#2 = 36%

#so there is an increasing in level 1 of 17% that is the cover land damaged by the fire in this area
#we buid a dataframe
#building the dataframe
class <- c("vegetation", "desert soil and urbanization") #we mention the two classes that will appear on x asses 
pjuly <- c(52, 47) #here the percentage of 1992
pseptember <- c(36, 64) #here the percentage of 2006

tabout <- data.frame(class, pjuly, pseptember) #we create a dataframe where we put the 2 classes and the related percentages for both years 
tabout #we visualize the table

#ggplot2 graphs
g1 <- ggplot(tabout, aes(x = class, y = pjuly, color = class)) + geom_bar(stat = "identity",   fill = "white") + ylim(c(0, 100))
#ggplot #with the initial part we only added a piece of the function: the table to plot, aestethic refers to the graphic structure so what we want in x and y and with which color; to create the graphic we need geom_bar
#geom_bar #stat refers to the statistic type we want to represent: mean, median...we want the exact values so we put "identify"; fill refers to the filling color 

#we do the same for september
g2 <- ggplot(tabout, aes(x = class, y = pseptember, color = class)) + geom_bar(stat = "identity", fill = "white") + ylim(c(0, 100))

g1 + g2 #with this simple sum we join them using package patchwork

g1/g2 
