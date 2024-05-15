#every time we start we have to recall the packages we need
library(terra)
library(imagery) 

im.list() #we see all the images that package terra has

#importing an image from terra
b2 <- im.import("sentinel.dolomites.b2.tif") #this is the blue band 

#we create a new color palette
clg <- colorRampPalette(c("black", "grey", "light grey"))(3) #3 refers to shades
plot(b2, col=clg) #we plot the image with the new color palette
clg <- colorRampPalette(c("black", "grey", "light grey"))(100) #color variations are much more
clg <- colorRampPalette(c("lightcyan", "aquamarine4", "lightcoral"))(100) #we switch from greys 

#importing others bands
b3 <- im.import("sentinel.dolomites.b3.tif") #the 3 band correspond to 530nm --> green
b4 <- im.import("sentinel.dolomites.b4.tif") #red
b8 <- im.import("sentinel.dolomites.b8.tif") #near infrared

#we can plot all the bands together to see the differences 
#multiframe
par(mf) #in this way we create the multiframe inside of which we will insert the images
#we load the plots that will be add by row 
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

#exercise
#plot the for bands one after the other in a single row
par(mfrow=c(1,4))
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

#let's make a satellite image
stacksent <- c(b2, b3, b4, b8) 
plot(stacksent, col=clg)

plot(stacksent[[4]], col=clg) #when we use rows and columns we need [[]]. Whenever we use raster files, because we are in 2 dimensions
dev.off() #we delete everything from the graphic table

#RGB plotting
#stacksent[[1]] = b2 = blue
#stacksent[[2]] = b3 = green
#stacksent[[3]] = b4 = red
#stacksent[[4]] = b8 = nir 

im.plotRGB(stacksent, r=3, g=2, b=1) #here's the image with its natural colors: we have to make corresponding to each filter the number of the band in the stack 
im.plotRGB(stacksent, 3, 2, 1) #we can omit r, g, b because they already exist in the function

im.plotRGB(stacksent, 4, 2, 1) #to see the image in nir; we substitute the red with the nir
im.plotRGB(stacksent, 4, 3, 2) #we also can rotate the bands so nir, red and green. One will always missing because we can put only 3. It doesn't matter because the nir is prevailing

#multiframe
par(mfrow=c(1,3)) #we create a multiframe with 1 row and 3 columns so we will see the two images closed one to the other
im.plotRGB(stacksent, 3, 2, 1) #we load the natural colours' image 
im.plotRGB(stacksent, 4, 2, 1) #we load the infrared visualization; red is no more represented
im.plotRGB(stacksent, 4, 3, 2) #blue is no more represented, but we see no differences between thisone and the one above

dev.off()

#to see nir in green
im.plotRGB(stacksent, 3, 4, 1) #in this way the nir band is used on green

#to see nir in blue
im.plotRGB(stacksent, 3, 2, 4) 

#final multiframe
par(mfrow=c(2,2)) #the usual multiframe, we will insert the natural colours' image and the ones with infrared in the various bands
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)
im.plotRGB(stacksent, 3, 4, 1)
im.plotRGB(stacksent, 3, 2, 4)

pairs(stacksent) #we see a diagram that shows us the correlation between the various bands 
