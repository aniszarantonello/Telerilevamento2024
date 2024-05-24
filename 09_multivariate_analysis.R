library(imageRy)
library(terra)
library(viridis)

im.list() 

#Importing data
sent2 <- im.import("sentinel.dolomites.b2.tif") #blu band
sent3 <- im.import("sentinel.dolomites.b3.tif") #green   
sent4 <- im.import("sentinel.dolomites.b4.tif") #red 
sent8 <- im.import("sentinel.dolomites.b8.tif") #nir 

#creating a stack
sentdo <- c(sent2, sent3, sent4, sent8)
sentdo

#visualizing the image
im.plotRGB(sentdo, r=4, g=3, b=2) #nir is on red, the red component will be visualized in green and green in blue  
im.plotRGB(sentdo, r=3, g=4, b=2) #nir on green 

dev.off()  

#calculating bands correlations 
pairs(sentdo)

#calcolculating pca 
pcimage <- im.pca(sentdo) #the function give back the ranges of various components, the first one is the one with most of the variability (the principal). Speaking about numbers they will be a bit different every time due to a casual sample #below there is the correlation between the band and components extracted from the analysis
tot <- sum(1705.70050, 570.32676, 43.70992, 25.22304) #we sum all various ranges of all axis obtained to have the total variability 

#Calculating the percentage of variability explained by a certain component
570.32676 * 100 / tot #percentage of the second 

vir <- colorRampPalette(viridis(7))(100) # creating a new color Palette
plot(pcimage, col = vir) #the first component is very well representative of the bands, while in the last one we don't understand nothing from the image, only background noise

plot(pcimage, col = viridis(100)) #I can avoid to do the color palette in this way. Because they already exist in viridis
plot(pcimage, col = plasma(100)) #changing color
