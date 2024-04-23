#questa è la banda b2 che è quella del blu

#creiamo una nuova palette di colori
clg<-colorRampPalette(c("black","grey","light grey"))(3) #3 sta per le sfumature
plot(sent,col=clg) 
clg<-colorRampPalette(c("black","grey","light grey"))(100) #così le variazioni di colore sono molte di più
clg<-colorRampPalette(c("lightcyan","aquamarine4","lightcoral"))(100) #usiamo colori diversi dai grigi

#carichiamo tutte le bande

b3<-im.import("sentinel.dolomites.b3.tif") #la 3 corrisponde a 530nm-->verde
b4<-im.import("sentinel.dolomites.b4.tif") #rosso
b8<-im.import("sentinel.dolomites.b8.tif") #vicino infrarosso

#plottiamoli tutti insieme per vedere le differenze
#multiframe
par(mf) #così creiamo il multiframe all'interno del quale inseriremo le immagini
par(mfrow=c(2,2)) #creiamo l'array 
#ancora non vediamo niente, è solo un telaio
#carichiamo i plot, li inserirà per riga
plot(sent,col=clg)
plot(b3,col=clg)
plot(b4,col=clg)
plot(b8,col=clg)

#exercise
#plot the for bends one after the other in a single row
par(mfrow=c(1,4))
plot(sent,col=clg)
plot(b3,col=clg)
plot(b4,col=clg)
plot(b8,col=clg)

#let's make a satellite image
stacksent<-c(sent,b3,b4,b8) 
plot(stacksent,col=clg)

plot(stacksent[[4]], col=clg) #quando usiamo righe e colonne servono due [[]]. quando si usano dei raster, perchè siamo in due dimensioni
dev.off() #cancella ciò che c'è nel quadro grafico

#stacksent[[1]]=b2=sent=blue
#stacksent[[2]]=b3=green
#stacksent[[3]]=b4=red
#stacksent[[4]]=b8=nir 

im.plotRGB(stacksent,r=3,g=2,b=1) #per fare l'immagine nei colori naturali; facciamo corrispondere a ogni filtro il numero della banda dello stack.
im.plotRGB(stacksent,3,2,1) #r,g,b possono essere tolti perchè son già presenti nella funzione

im.plotRGB(stacksent,4,2,1) #to see the image in nir
im.plotRGB(stacksent,4,3,2)

#multiframe
par(mfrow=c(1,2)) #così facciamo un multiframe con 1 riga e due colonne quindi vedremo le due immagini vicine
im.plotRGB(stacksent,3,2,1) #carichiamo l'immagine a colori naturali
im.plotRGB(stacksent,4,2,1) #carichiamo la visualizzazione all'infrarosso

im.plotRGB(stacksent,4,3,2)

#to see nir in green
im.plotRGB(stacksent,3,4,1) #così la banda dell'infrarosso è usata nel verde
im.plotRGB(stacksent,3,2,4)

#final multiframe
par(mfrow=c(2,2)) #il solito multiframe a 4 immagini, ci inseriremo l'immagine a colori naturali e quelle a infrarosso, sulle varie bande.
im.plotRGB(stacksent,3,2,1)
im.plotRGB(stacksent,4,2,1)
im.plotRGB(stacksent,3,4,1)
im.plotRGB(stacksent,3,2,4)

pairs(stacksent) #ci fa vedere un grafico che ci mostra la correlazione tra le varie bande


b2 #i have information on the image: class, dimensions(pixels on rows and columns), resolution, SR





