library(terra)
library(imageRy)

im.list() #we ask for the list of images

#importing data
gennaio <- im.import("EN_01.png") #european nitrogen, first photo: january 
marzo <- im.import("EN_13.png") #european nitrogen, last photo: march

par(mfrow = c(2, 1)) #we create a multiframe with a column and two rows
im.plotRGB.auto(gennaio) #this function with "auto" takes directly the firsts 3 bands and does all automathically; we add the first image
im.plotRGB.auto(marzo) #we add the second image in the multiframe

#we do the difference of the first band
difEN = gennaio[[1]] - marzo[[1]] #pixels of the 1 band of the first image are subttract to them of the same band in the second image 
cl <- colorRampPalette(c("blue", "white", "red")) (100) #we create a color palette
plot(difEN, col=cl) #we plot the difference using the cl color palette
#we obtein a quantification of the difference: using an image at 8 bit the range will be from -255 to 255

#Ice melt in Grenland
G2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100) #we create a new palette adding the black; we mention it in a different way from the recent one not to overwrite it

#importing other data
G2005 <- im.import("greenland.2005.tif") 
G2010 <- im.import("greenland.2010.tif")
G2015 <- im.import("greenland.2015.tif")

#multiframe
par(mfrow = c(2, 2)) #we create a multiframe where we can put all the 4 images
plot(G2000, col = clg) 
plot(G2005, col = clg)
plot(G2010, col = clg)
plot(G2015, col = clg) #we plot all the images

#stack
greenland <- c(G2000, G2005, G2010, G2015) #we create a stack
plot(greenland, col=clg) #we plot the stack

dev.off() #we clean the graphic table

#differences between images
difg = greenland[[1]] - greenland[[4]] #we remove the 2015 from the 2000
plot(difg, col = cl) #we use the color palette without black, where the blue is the lowest temperature

#new color palette
col <- colorRampPalette(c("red", "white", "blue")) (100) #we can change the color palette in order to have red those areas where we have an increasing temperature 

#RGB plot
im.plotRGB(greenland, r=1, g=2, b=4) #we link at every RGB component one of the levels of the stack: G2000 on red, G2005 on green, G2015 on blue so that we can see in red those areas where the T was higher in 2000 and so on
