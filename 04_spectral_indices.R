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
im.plotRGB(m2006, 1, 2, 3) #così plottiamo l'infrarosso nel rosso? il prof non lo fa perchè dice che è uguale.
im.plotRGB(m2006, 2, 1, 3) #nir on green
im.plotRGB(m2006, 2, 3, 1) #nir on blue

#we make a multiframe with all the images
par(mfrow=c(2,3)) #2 rows and 3 columns where rows refers to 1992 and 2006, and in columns there is the nir in the various bands
#adesso carichiamo tutte le immagini
im.plotRGB(m1992,1,2,3) #nir on red
im.plotRGB(m1992,2,1,3) #nir on green
im.plotRGB(m1992,2,3,1) #nir on blue
im.plotRGB(m2006,1,2,3) #nir on red
im.plotRGB(m2006,2,1,3) #nir on green
im.plotRGB(m2006,2,3,1) #nir nel blu

#possiamo espostarlo in png o pdf non so come

#calcoliamo il DVI (Difference Vegetation Index)
#banda 1=nir
#banda 2=red
dvi1992=m1992$matogrosso_l5_1992219_lrg_1 - m1992$matogrosso_l5_1992219_lrg_2

dvi1992=matogrosso~2219_lrg_1 - matogrosso~2219_lrg_2 #questo un modo alternativo. richiamo le bande con il nome dell'immagine, così mi escono le info

#plot
cl<-colorRampPalette(c("darkblue","yellow","red","black"))(100) #prima creiamo la palette di colori
plot(dvi1992, col=cl)

#calcoliamo il DVI del 2006
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg") #prima rinominiamo l'immagine
dvi2006=m2006$matogrosso_ast_2006209_lrg_1 - m2006$matogrosso_ast_2006209_lrg_2
dvi2006 #così vediamo valori max e min
cl<-colorRampPalette(c("darkblue","yellow","red","black"))(100) #prima creiamo la palette di colori
plot(dvi2006, col=cl)

#plot dvi1996 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

#calcoliamo NDVI (Normalised Difference Vegetation Index)
ndvi1992=dvi1992/(m1992[[1]]+m1992[[2]])
ndvi2006=dvi2006/(m2006[[1]]+m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992,col=cl)
plot(ndvi2006,col=cl)




