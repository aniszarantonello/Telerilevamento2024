#quantiffying land cover change

install.packages("ggplot2") #weinstall  new package that we will use 
library(ggplot2) #we call back the package
library(terra) 
library(imageRy) #we call back all the packages we will need

#listing images
im.list() 

#importing data
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #we start using a new image 

sunc <- im.classify(sun, num_clusters = 3) #we decide to classify the image with 3 groups/clusters 

#importing matogrosso images
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#classifying images
m1992c <- im.classify(m1992, num_cluster = 2) #in this case we are intrested in the forest so we put 2 clusters: the forest and all the rest

#class 1 = forest
#class 2 = river and human modification

m2006c <- im.classify(m2006, num_cluster = 2) #we classify also the image from 2006 using 2 clusters as well

#class 1 = forest
#class 2 = human
#we have to pay attention because the two classes could be inverted since is a random process (the first pixel picked up) 

plot(m1992c) #così ricontrolliamo 
plot(m2006c)

#calculating frequencies
f1992 <- freq(m1992c) #the response of R will be the count of pixels organized in the two classes

#proportions
tot1992 <- ncell(m1992c) #this is the total number of pixels
prop1992 = f1992 / tot1992 #is a proportion between the frequences and the total

#percentages
perc1992 = prop1992 * 100 #we multiplicate the proportion per 100 #percentages: forest=83%, human=17%

#we do the same for matogrossum 2006
f2006 <- freq(m2006c) 
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006
perc2006 = prop2006 * 100 #percentages06: forest=45%, human=54%

#building the dataframe
class <- c("forest", "human") #we mention the two classes that will appear on x asses 
p1992 <- c(83, 17) #here the percentage of 1992
p2006 <- c(45, 55) #here the percentage of 2006

#building the dataframe
tabout <- data.frame(class, p1992, p2006) #we create a dataframe where we put the 2 classes and the related percentages for both years 
tabout #we visualize the table

#ggplot2 graphs
ggplot(tabout, aes(x = class, y = p1992, color = class)) + geom_bar(stat = "identity",   fill = "white")
#ggplot #with the initial part we only added a piece of the function: the table to plot, aestethic refers to the graphic structure so what we want in x and y and with which color; to create the graphic we need geom_bar
#geom_bar #stat refers to the statistic type we want to represent: mean, median...we want the exact values so we put "identify"; fill refers to the filling color 

#we do the same for 2006
ggplot(tabout, aes(x = class, y = y2006, color = class)) + geom_bar(stat = "identity", fill = "white")

#to blend the two graphics in only one we need a new package 
install.packages("patchwork") #we install the package
p1 <- ggplot(tabout, aes(x = class, y = y1992, color = class)) + geom_bar(stat = "identity", fill = "white") #we mention the first graphic
p2 <- ggplot(tabout, aes(x = class, y = y2006, color = class)) + geom_bar(stat = "identity", fill = "white") #we mention also the second one
p1 + p2 #with this simple sum we join them

#correcting for y axis range: so that the two graphs have the same scale
p1 <- ggplot(tabout, aes(x = class, y = y1992, color = class)) + geom_bar(stat = "identity", fill = "white") + ylim(c(0, 100)) #we want the y axis to vary between 0 and 100. 
p2 <- ggplot(tabout, aes(x = class, y = y2006, color = class)) + geom_bar(stat = "identity", fill = "white")+ ylim(c(0, 100)) #the same for the second graphic
p1 + p2 #now both graphics have the same scale and that's ok to make comparisons
