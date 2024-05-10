# First R script

# R used to calculate
a <- 5 * 7
b <- 4 * 2
a + b

# using arrays: concatenate some elements
flowers <- c(3, 6, 8, 10, 15, 18)
flowers
insects <- c(10, 16, 25, 42, 61, 73)
insects

# plotting data
plot(flowers, insects)

#changing plot parameters

#symbols
plot(flowers, insects, pch=19) #we change the symbol in the graph

#dimension
plot(flowers, insects, pch=19, cex=3) #we increase the dimension of the symbol
plot(flowers, insects, pch=19, cex=0.5) #this function is to reduce the dimension

#color
plot(flowers, insects, pch=19, cex=3, col="cyan4") #there is a table with all the names of possible colors in R
