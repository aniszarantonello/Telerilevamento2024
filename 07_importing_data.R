#importing data from external sources

#I have downloaded the file eclissi.png in "Download" of my PC

library(terra) 
library(imageRy)

setwd("C:/Users/anisz/Downloads") #we explain to the system in which folder of my PC it has to extract the data we want to import #wd refers to working directory
#nb x windows: using the backslash doesn't work for R, we have to invert \ (proprieties of the file) with /

#importing images
eclissi <- rast("eclissi.png") #this function creates SpatRaster objects #pay attention to the name, the extension is fundamental
eclissi #in this way we recall the image so we have various data back

#plotting data
im.plotRGB(eclissi, 1, 2, 3) #we see the image with original colors; we don't know which are the bands but we can invert them to visualize the image in the various bands
im.plotRGB(eclissi, 3, 2, 1)
im.plotRGB(eclissi, 2, 3, 1)

#difference between the bands
dif = eclissi[[1]] - eclissi[[2]]
dif

#importing images from Copernicus: we save the image in the PC in the same working directory
soil <- rast("soil.nc")
plot(soil) #in this way I plot the image 
plot(soil[[1]]) #I only plot the first level 

#crop data
ext <- c(25, 30, 55, 48) #I can cut the image with this cut out extension, we have to define xmin, xmax, ymin and ymax
soilcrop <- crop(soil, ext) #I obtain a ne new variable 
plot(soilcrop) #I can plot it
plot(soilcrop[[1]]) 
