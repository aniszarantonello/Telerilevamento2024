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

