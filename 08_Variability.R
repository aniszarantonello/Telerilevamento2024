library(terra)
library(imageRy)

im.list() #as always in this way we obtain the list of files

#we use the sentinel image
sent <- im.import("sentinel.png") #is an image with 4 bands but one is for control; we only need 3 levels 

# la plottiamo con solo le tre bande che ci servono 
im.plotRGB(sent, 1, 2, 3)
#NIR = banda 1, red = banda 2, green = banda 3. Questo vuol dire che la parte rossa (relazionata al NIR) è la parte di bosco e prateria. 

# possiamo giocare un po' con i colori di RGB 
im.plotRGB(sent, 2,1,3) #si nota un po' meglio la differenza tra prateria e bosco

# ora calcoliamo la deviazione standard (ma solo su una banda, non tutte e tre), quello che facciamo questo caso è sceglierne una, nella prossima lezione facciamo analisi multivariata
# di solito si usa il livello che maggiormente descrive gli oggetti, quindi in questo caso il nir. 
nir <- sent[[1]] #per evitare di scrivere sent[[1]] tutte le volte. 

#creo color ramp palette 
cl<-colorRampPalette(c("black", "blue", "green", "yellow")) (100)
plot(nir, col=cl)

# funzione focal, si usa per calcolare la variabilità, si usa la moving window 
sd3 <- focal(nir, matrix(1/9, 3,3), fun=sd) 
#primo oggetto è su cosa si basa, poi dobbiamo descrivergli la finestra usando una matrice (sono stessi elementi come in vettore ma disposti in 2 dimensioni)
# all'interno di matrix dobbiamo mettere tre argomenti, il primo il range di pixel da prendere (mettiamo da quale a quale quindi 1/9), come sono diposti (in questo caso non c'è dubbio ma dobbiamo mettere come diporli quindi 3,3)
# in focal dobbiamo anche mettere la funzione che vogliamo calcolare, quindi nel nostro caso sd (standard deviation)
# diamo il nome al tutto per es sd3, importante non sd perchè altrimenti riconosce sd come oggetto e non come funzione 

#plottiamo questa diversità
plot(sd3) #vediamo che non si nota moltissimo la variabilità 

#esistono colorampalette che sono adatte anche a persone con daltonia, dobbiamo installare il pacchetot viridis che le contiene 
install.packages("viridis")
library(viridis)

# creiamo una nuova color ramp palette con i colori di viridis. ci sono codici che rispecchiamo determinate scale cromatiche all'interno di viridis
viridisc <- colorRampPalette(viridis(7)) (256)
plot(sd3, col=viridisc)
# in questo caso sono visibili da tutti i daltonici

# ora proviamo ad allargare la moving window a 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# facciamo uno stack con i due calcoli di deviazione standard per vederli assieme 
stacksd <- c(sd3, sd7)
plot(stacksd, col= viridisc)
# notiamo come allargando si sfochi l'immagine 

# ora gaurdiamo il 13 x 13 per vedere come cambia 
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)
plot(sd13, col=viridisc)
stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col= viridisc)
# anche in questo caso si vede bene come aumenti la sfocatura dovuto al fatto che usiamo un numero sempre maggiore di pixel per calcolare la nostra deviazione standard.
