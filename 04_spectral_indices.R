#vegetation indeces

library(terra) #as always we have to call back the packages because we need them to use some functions that R normally doesn't have
library(imageRy)

im.list() #we ask for a list of all available files in the package 

#today we use images from Matogrosso 1992
im.import("matogrosso_l5_1992219_lrg.jpg") #we import the image; we have to use "" because in imageRy they are nominated in this way
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #we mention the image as we want

# band 1 = nir = R
# band 2 = red = G
# band 3 = green = B

im.plotRGB(m1992, 1, 2, 3) #this is the same image we saw when we imported it 
im.plotRGB(m1992, 2, 1, 3) #in this way we put the nir in the green component of the image 
im.plotRGB(m1992, 2, 3, 1) #nir is on blue

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") #we import image from 2006 and we mention it directly. The automatic plot uses the first 3 bands 
im.plotRGB(m2006, 1, 2, 3) #in this way nir is on red 
im.plotRGB(m2006, 2, 1, 3) #nir on green
im.plotRGB(m2006, 2, 3, 1) #nir on blue

#we make a multiframe with all the images
par(mfrow=c(2,3)) #2 rows and 3 columns where rows refers to 1992 and 2006, and in columns there is the nir in the various bands
#now we load all images 
im.plotRGB(m1992, 1, 2, 3) #nir on red
im.plotRGB(m1992, 2, 1, 3) #nir on green
im.plotRGB(m1992, 2, 3, 1) #nir on blue
im.plotRGB(m2006, 1, 2, 3) #nir on red
im.plotRGB(m2006, 2, 1, 3) #nir on green
im.plotRGB(m2006, 2, 3, 1) #nir on blue


#Calculating the DVI (Difference Vegetation Index)
#band 1 = nir
#band 2 = red
dvi1992 = m1992[[1]] - m1992[[2]] 
#alternative way
dvi1992 = matogrosso~2219_lrg_1 - matogrosso~2219_lrg_2 #I call back the bands with their names: writing the name of the image I have info back about the bands' names

#plot
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) #this is the new color palette we will use
plot(dvi1992, col=cl) #we plot the DVI using the new color palette

#we calculate the DVI of the 2006 image 
dvi2006 = m2006[[1]] - m2006[[2]] 
#dvi2006 = m2006$matogrosso_ast_2006209_lrg_1 - m2006$matogrosso_ast_2006209_lrg_2 #this is also a way
dvi2006 #the answer on R will report max and min values 
plot(dvi2006, col=cl) #we plot the DVI using the same color palette as we did before

#plot dvi1996 beside the dvi2006
par(mfrow=c(1,2)) #our multiframe has a single row and 2 columns
plot(dvi1992, col=cl) #we add the DVI plot from 1992
plot(dvi2006, col=cl) #we add the DVI plot from 2006

#Calcolculating the NDVI (Normalised Difference Vegetation Index)
ndvi1992 = dvi1992/(m1992[[1]]+m1992[[2]]) #we simply have divided the DVI (which is a difference between nir and red ) with the sum nir + red
ndvi2006 = dvi2006/(m2006[[1]]+m2006[[2]]) #the same for the 2006

dev.off()

par(mfrow=c(1,2)) #multiframe with the two NDVI
plot(ndvi1992, col=cl) #we plot the 1992 image with the color palette we created before
plot(ndvi2006, col=cl) #we add the NDVI from 2006
