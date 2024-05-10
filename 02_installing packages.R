#installing new packages in R
install.packages("terra") #with this function we can install packages from the CRAN 
library(terra) #you can call the package and hope there aren't any problems
install.packages("devtools") #we will use it later
library(devtools)
install_github("ducciorocchini/imageRy") #this is how we can install packages from github
library(imageRy) 
