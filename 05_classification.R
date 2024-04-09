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

