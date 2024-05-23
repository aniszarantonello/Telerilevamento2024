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
im.plotRGB(sentdo, r=4,g=3,b=2) #metto il nir nel rosso (vegetazione viene rossa), la componente rossa è visualizzata nel verde e la componente verde è visualizzata nel blu. 
# posso anche visualizzarlo con il nir nel verde 
im.plotRGB(sentdo, r=3,g=4,b=2)

#calcola tutte le correlazioni tra le bande 
dev.off() #sempre utile fare un po' di pulizia 
pairs(sentdo) #attenzione, correlazione non è causalità. 

#calcoliamo la pca 
pcimage <- im.pca(sentdo)
# restituisce i range delle varie componenti, la prima è quella a variabilità maggiore (la principale). Numericamente vengono un po' diversi se faccio diverse ripetizioni, questo è dovuto al fatto che si basa su un campione estratto casualmente 
# sotto c'è anche la correlazione tra banda e componenti estratte dall'analisi. 

# sommiamo i vari range di tutti gli assi ottenuti per avere la variabilità totale
tot <- sum(1705.70050, 570.32676, 43.70992, 25.22304)

# calcolo la percentuale di variabilità che è spiegata da una certa componente 
1705.70050 * 100 /tot #restituisce la percentuale di variabilità spiegata dalla prima componente 
570.32676 * 100 / tot #percentuale dalla seconda 

# creo una colorRampPalette
vir <- colorRampPalette(viridis(7))(100) 
plot(pcimage, col=vir) #vedo che la prima compontente è molto ben rappresentativa delle bande (immagine ancora si capisce), mentre nell'ultima non si capisce più nulla (immagine non chiara), solo rumore di fondo

# vedo che posso anche scrivere direttamente plot(pcimage, col=viridis(100)) ed evitare di fare la colorampalette 
plot(pcimage, col=viridis(100))
# posso anche cambiare il colore 
plot(pcimage, col=plasma(100))



---


im.pca  #compattiamo il set in più dimensioni

library(terra)
library(imageRy)
install.packages("viridis")
library(viridis)

im.list()
#importing data
b2<-im.import("sentinel.dolomites.b2.tif") #blue
b3<-im.import("sentinel.dolomites.b3.tif") #green
b4<-im.import("sentinel.dolomites.b4.tif") #red
b8<-im.import("sentinel.dolomites.b8.tif") #nir

#creating a stack
sentdo<-c(b2,b3,b4,b8)

im.plotRGB(sentdo, r=4, g=3, b=2)
im.plotRGB(sentdo, r=3, g=4, b=2)

pairs(sentdo)

pcimage<-im.pca(sentdo) 

#vogliamo estrarre le percentuali di ogni componente
tot<-sum(1375.29098,639.56879,54.88589,38.57959) #la somma di tutti i vari range per ogni asse
1375.29098*100/tot #per sapere la variabilità spiegata dalla prima componente; ha la maggiore varianza spiegata 
639.56879*100/tot #la seconda componente ha il 30% #e così via per le altre, sempre a diminuire

vir<-colorRampPalette(viridis(7))(100)
plot(pcimage, col=vir)

#oppure
plot(pcimage, col=viridis(100))

#da un sistema quadridimensionale siamo riusciti a passare a un sistema quasi monodimensionale dove il 70% è spiegato dalla prima componente principale

