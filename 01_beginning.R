# First R script

# R used to calculate
a<-5*7
b<-4*2
a+b

# using arrays: concatenate some elements
flowers<-c(3,6,8,10,15,18)
flowers
insects<-c(10,16,25,42,61,73)
insects

# plotting data
plot(flowers,insects)

#changing plot parameters
#symbol
plot(flowers,insects,pch=19)
#dimension
plot(flowers,insects,pch=19,cex=3)
plot(flowers,insects,pch=19,cex=0.5) #this function is to reduce the dimension
#color
plot(flowers,insects,pch=19,cex=3,col="cyan4")
