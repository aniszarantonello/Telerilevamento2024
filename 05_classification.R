#quantiffyng land cover change

install.packages("ggplot2") #così installiamo il nuovo pacchetto 
library(ggplot2) #richiamiamo il pachhetto
library(terra)
library(imageRy) #richiamiamo tutti i pacchetti che ci servono

#listing images
im.list() #chiediamo la lista di immagini presenti nel pacchetto

#importing data
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc<-im.classify(sun,num_clusters=3) #

#matogrosso images
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#classifying images
m1992c<-im.classify(m1992,num_cluster=2) #ci interessa la foresta e tutto il resto quindi basta due

#class 1=forest
#class 2=river and human modification

m2006c<-im.classify(m2006,num_cluster=2)

#class 1=forest
#class 2=human
#attenzione che le classi potrebbero invertirsi tra una foto e l'altra

plot(m1992c) #così ricontrolliamo 
plot(m2006c)

#calculating frequencies
f1992<-freq(m1992c)
f1992 #così vediamo il conteggio dei pixel
tot1992<-ncell(m1992c) #così abbiamo il tot dei pixel
prop1992=f1992/tot1992
prop1992
perc1992=prop1992*100

#percentages: forest=83%, human=17%

f2006<-freq(m2006c)
f2006
tot2006<-ncell(m2006c)
prop2006=f2006/tot2006
prop2006
perc2006=prop2006*100
perc2006

#percentages06: forest=45%, human=54%

#building the dataframe
class<-c("forest","human")
y1992<-c(83,17)
y2006<-c(45,55)

tabout<-data.frame(class,y1992,y2006) #creiamo un dataframe in cui inserire le percentuali
tabout #la visualizziamo

#ggplot2 graphs
geom_bar(stat="identity",fill="white") #tipo di statistica che noi vogliamo rappresentare:media,mediana...noi vogliamo i valori esatti che abbiamo quindi identity; fill è il colore con il quale vogliamo riempire il grafico
ggplot(tabout,aes(x=class,y=y1992,color=class)) + geom_bar(stat="identity",fill="white") #nn vaaa
#aestethic riguarda la struttura del grafico
#con la prima parte abbiamo solo aggiunto un pezzo di funzione, per fare il grafico serve geom_bar

#facciamo lo stesso per 2006
ggplot(tabout,aes(x=class,y=y2006,color=class)) + geom_bar(stat="identity",fill="white")


install.packages("patchwork")
p1<-ggplot(tabout,aes(x=class,y=y1992,color=class)) + geom_bar(stat="identity",fill="white")
p2<-ggplot(tabout,aes(x=class,y=y2006,color=class)) + geom_bar(stat="identity",fill="white")
p1+p2

#correcting for y axis range
p1<-ggplot(tabout,aes(x=class,y=y1992,color=class)) + geom_bar(stat="identity",fill="white")+ylim(c(0,100)) #chiediamo che l'asse delle y vada da 0 a 100
p2<-ggplot(tabout,aes(x=class,y=y2006,color=class)) + geom_bar(stat="identity",fill="white")+ylim(c(0,100))
p1+p2 #adesso i due grafici hanno la stessa scala per cui è facile fare confronti






