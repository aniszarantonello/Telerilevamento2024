library(terra)
library(imageRy)

im.list() #as always in this way we obtain the list of files

#we use the sentinel image
sent <- im.import("sentinel.png") #is an image with 4 bands but one is for control; we only need 3 levels 

#we only plot the 3 bands we need
im.plotRGB(sent, 1, 2, 3)
#NIR = band 1, red = band 2, green = band 3. This means that in red (related to NIR) we see woods and grassland

#we can change the colors on RGB 
im.plotRGB(sent, 2, 1, 3) #we can see better the difference between woods and grassland

#now we can calculate the standard deviation (only on a single band), now we choose a single one and in the next lesson we will see the multivariate analysis
#normally we use the level that better describes the objects, the nir in this case 
nir <- sent[[1]] #this is to avoid writing "sent[[1]]" every time

#creating a color palette 
cl <- colorRampPalette(c("black", "blue", "green", "yellow")) (100)
plot(nir, col=cl)

#calculating variability
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd) #this function allows to calculate variability, we use moving window 
#the first object refers to the band, than we have to describe the window using a matrix (the same elements as in a vector but here they are in two dimensions)
#the 3 arguments in matrix refer to: the range of pixel to take, from 1 till 9, in which way they are organized (3, 3) 
#fun refers to the funcion we want to calculate and sd refers to standard deviation

#plotting the variability
plot(sd3) #in our case we don't see a lot of variability 

#installing viridis
install.packages("viridis") #in this package there are some color palette that can be well seen by color-blind people 
library(viridis)

#we create a new color palette with colors from viridis. Codes reflect determined chromatic scale inside viridis
viridisc <- colorRampPalette(viridis(7)) (256) #this is the color palette
plot(sd3, col=viridisc) #we plot the sd with the color palette from viridis

#we can enlarge the moving window up to 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun = sd)
plot(sd7, col = viridisc)

#stack
stacksd <- c(sd3, sd7) #in this way we see both calculations toghether
plot(stacksd, col = viridisc)

#now we do a moving window 13 x 13 to see the changment 
sd13 <- focal(nir, matrix(1/169, 13, 13), fun = sd)
plot(sd13, col = viridisc)

stacksd2 <- c(sd3, sd7, sd13) #creating a new stack
plot(stacksd2, col = viridisc) #we can see that the blurring improves due to the increasing number of pixel we use to calculate the sd
