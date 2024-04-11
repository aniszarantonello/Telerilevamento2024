library(terra)
library(imageRy)

im.list()

#importing data
#usiamo le foto EN: european nitrogen, da gennaio a marzo
gennaio<-im.import("EN_01.png") #prima foto, gennaio
marzo<-im.import("EN_13.png") #ultima foto, marzo

par(mfrow=c(2,1)) #creiamo un multiframe a una colonna e due righe
im.plotRGB.auto(gennaio) #la funzione con l'aggiunta di "auto" prende direttamente le prime tre bande e fa tutto in automatico; aggiungiamo la prima immagine
im.plotRGB.auto(marzo) #aggiungo la seconda immagine

#
difEN=gennaio[[1]]-marzo[[1]] #i pixel della prima banda sono sottratto a quelli della prima banda dell'altra immagine
col<-colorRampPalette(c("blue","white","red"))(100) #scelgo la banda di colori
plot(difEN,col=col)

##Ice melt in Grenland
G2000<-im.import("greenland.2000.tif")
clg<-colorRampPalette(c("black","blue","white","red")) (100) #chiamandola diversamente da prima evitiamo di sovrascrivere e quindi sostituire la color paette precedente
plot(G2000,col=clg)

#importing other data
G2005<-im.import("greenland.2005.tif") 
G2010<-im.import("greenland.2010.tif")
G2015<-im.import("greenland.2015.tif")

par(mfrow=c(1,2))
plot(G2000,col=clg)
plot(G2015,col=clg)

par(mfrow=c(2,2))
plot(G2000,col=clg)
plot(G2005,col=clg)
plot(G2010,col=clg)
plot(G2015,col=clg)

#stack
greenland<-c(G2000,G2005,G2010,G2015)
plot(greenland,col=clg)

difg=greenland[[1]]-greenland[[4]]
plot(difg,col=col)

cl<-colorRampPalette(c("red","white","blue")) (100) #invertiamo la palette in modo da vedere il rosso nelle zone in cui la T è aumentata
plot(difg,col=cl)

im.plotRGB(greenland,r=1,g=2,b=4) #G2000 on red, G2005 on green, G2015 on blue







