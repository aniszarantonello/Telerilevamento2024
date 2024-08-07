## The aim of the project is to calculate the area damaged by the fire that affected Tenerife island from the 15th of august till the 5th of september 2023.
# Data taken from Copernicus Browser

# If you don't already have all the packages installed, you can install all of them with the function install.packages("the name of it"), 
# except for imagery which is not in the CRAN so the function needed is install_github("ducciorocchini/imageRy").

# first of all we recall all the packages we need 
library(terra) #to use satellite images
library(imageRy) #for manipulating raster images in R
library(viridis) #for color palettes
library(ggplot2) #to create graphs
library(patchwork) #for coupling ggplot2 graphs

# We set the working directory
setwd("C:/Users/anisz/Downloads") # We explain to the system in which folder of my PC it must extract the data we want to import.

## We calculate the NBR index, a standard for fire severity assessment, which is used to highlight burned areas in large fire zones.
## We first calculate it for july and then for september.

cl.tn <- colorRampPalette(c("yellow", "slateblue", "wheat4")) (100) # Creating a color palette

# Loading images
july <- rast("luglio_swir.jpg")
sept <- rast("settembre_swir.jpg")
# 1 = B12 = SWIR
# 2 = B8 = NIR
# 3 = B4 = red
par(mfrow = c(1,2)) # Creating a multiframe
plot(july) # Adding images to the multiframe 
plot(sept)

dev.off()

## July NBR
plot(july[[1]], col = cl.tn, main="July SWIR")  # Swir: absorbed by vegetation # With main we add a title
plot(july[[2]], col= cl.tn, main="September SWIR")  # Nir: reflected by vegetation

diff.july = july[[2]] - july[[1]] 
plot(diff.july, col = cl.tn)
sum.july = july[[1]] + july[[2]]
plot(sum.july, col = cl.tn)
NBR_july = (diff.july) / (sum.july) 

viridis <- colorRampPalette(viridis(7))(255) # Using package viridis 
plot(NBR_july, col = viridis) 

## September NBR
plot(sept[[1]], col = cl.tn, main="July SWIR") #swir
plot(sept[[2]], col= cl.tn, main="September SWIR") #nir
diff.sept = sept[[2]] - sept[[1]]
plot(diff.sept, col = cl.tn)
sum.sept = sept[[1]] + sept[[2]]
plot(sum.sept, col = cl.tn)
NBR_sept = (diff.sept) / (sum.sept)

plot(NBR_sept, col = viridis)

# We put them on a stack
NBRstack <- c(NBR_july, NBR_sept)
names(NBRstack) <- c("NBR july", "NBR september")
plot(NBRstack, col = viridis)

# dNBR or delta NBR can be used to estimate the burn severity. Is the difference between the pre-fire and post-fire NBR.
dNBR = (NBR_july) - (NBR_sept)
plot(dNBR, col = viridis, main="dNBR")
# A higher value of dNBR indicates more severe damage;
# Areas with negative dNBR values may indicate regrowth following a fire.

# Now we zoom to the region that has been more damaged from the wildfire, we take a 10x10km square.
# We calculate the NBR and the dNBR
# We do the classification

julyB <- rast("zona1_luglio_swir.jpg")
plot(julyB)
septB <- rast("zona1_sett_swir.jpg")
plot(septB)

par(mfrow = c(1,2)) 
plot(julyB)
plot(septB)

dev.off()

## JulyB NBR
plot(julyB[[1]], col = cl.tn)  # Swir: absorbed by vegetation
plot(julyB[[2]], col= cl.tn)  # Nir: reflected by vegetation

diff.julyB = julyB[[2]] - julyB[[1]] 
plot(diff.julyB, col = cl.tn)
sum.julyB = julyB[[1]] + julyB[[2]]
plot(sum.julyB, col = cl.tn)
NBR_julyB = (diff.julyB) / (sum.julyB)

viridis <- colorRampPalette(viridis(7))(255) # Recall package viridis
plot(NBR_julyB, col = viridis) # we use viridis to enhance differences

## September NBR
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

# Calculating the dNBR 
dNBR2 = (NBR_julyB) - (NBR_septB)
plot(dNBR2, col = viridis, main="dNBR")

# Now we try yo do a classification on the NBR to calculate the area damaged
plot(NBR_julyB, col = viridis) 
plot(NBR_septB, col = viridis)

NBRluglio_c <- im.classify(NBR_julyB, num_clusters = 2) # We classify with 2 clusters of pixels.
plot(NBRluglio_c, main="July") # Plotting the classification with "July" as title.
NBRsett_c <- im.classify(NBR_septB, num_clusters = 2) # Same for september
plot(NBRsett_c, main="September")
#1 no vegetation
#2 is vegetation

## Calculating frequencies, proportions and percentages for july
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
#1 = 47% = no vegetation
#2 = 52% = vegetation

## Calculating frequencies, proportions and percentages for september
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
#1 = 64% = no vegetation 
#2 = 36% = vegetation

# So there is an increasing in level 1 of 17% that is the cover land damaged by the fire in this area.

# We buid a dataframe
classes <- c("vegetation", "desert soil and urbanization") # We mention the two classes that will appear on x asses 
pjuly <- c(52, 47) # Here the percentage of july classes
pseptember <- c(36, 64) # Here the percentage of september classes

tabout <- data.frame(classes, pjuly, pseptember) # We create a dataframe where we put the 2 classes and the related percentages for both years 
tabout #we visualize the table

#ggplot2 graphs
g1 <- ggplot(tabout, aes(x = classes, y = pjuly, color = classes)) + geom_bar(stat = "identity",   fill = "white") + ylim(c(0, 100))
# ggplot # With the initial part we only added a piece of the function: the table to plot,
# aestethic refers to the graphic structure so what we want in x and y and with which color; to create the graphic we need geom_bar.
# geom_bar # stat refers to the statistic type we want to represent: we want the exact values so we put "identify"; fill refers to the filling color.
# Limits in y are necessary to make sure that we have the same scale in both graphs, to better compare them
# We do the same for september
g2 <- ggplot(tabout, aes(x = classes, y = pseptember, color = classes)) + geom_bar(stat = "identity", fill = "white") + ylim(c(0, 100))

g1/g2  # with this simple fraction we join them using package patchwork
