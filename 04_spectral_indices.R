#indici di vegetazione

library(terra) #come al solito i pacchetti vanno richiamati perchè ci servono per usare funzioni che R normalmente non ha
library(imageRy)

im.list() #ci viene data una lista dei file disponibili dal pacchetto
#oggi usiamo le immagini del matogrosso del 1992
im.import("matogrosso_l5_1992219_lrg.jpg") #importiamo l'immagine; dentro imagerY abbiamo le immagini con "" quidi vanno usate
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg") #così rinominiamo l'immagine



im.plotRGB(m1992,1,2,3) #viene fuori la stessa immagine che plottava nel momento in cui l'abbiamo importata
im.plotRGB(m1992,2,1,3) #così mettiamo l'infrarosso nella componente verde dell'immagine

im.plotRGB(m1992,2,3,1) #cambiamo il nir sul blu

m2006<-im.import("matogrosso_ast_2006209_lrg.jpg") #importiamo l'immagine del 2006 e le diamo un nuovo nome. il plot automatio usa le prime tre bande
im.plotRGB(m2006,1,2,3) #così plottiamo l'infrarosso nel rosso? il prof non lo fa perchè dice che è uguale.
im.plotRGB(m2006,2,1,3) #nir nel verde
im.plotRGB(m2006,2,3,1) #nir nel blu

