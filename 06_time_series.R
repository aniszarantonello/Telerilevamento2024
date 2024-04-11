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




