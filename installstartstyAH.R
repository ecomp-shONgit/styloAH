print("R Script to install/start stylo Ancient History Edition.")

thewd <- getwd()
theinstdir <- dirname(thewd)

print("Build directory for stylo AH:")
print( theinstdir )
setwd( theinstdir )


#DEPENDENCIES  
print("Check for / install dependancies:")
if (!require( "tcltk2", character.only = TRUE)) {
	install.packages("tcltk2", dependencies = TRUE)     
}
if (!require( "pamr", character.only = TRUE)) {
	install.packages("pamr", dependencies = TRUE)     
}
if (!require( "e1071", character.only = TRUE)) {
	install.packages("e1071", dependencies = TRUE)     
}
if (!require( "tsne", character.only = TRUE)) {
	install.packages("tsne", dependencies = TRUE)     
}
if (!require( "readr", character.only = TRUE)) {
	install.packages("readr", dependencies = TRUE)     
}
if (!require( "reticulate", character.only = TRUE)) {
	install.packages("reticulate", dependencies = TRUE)     
}
if (!require( "ape", character.only = TRUE)) {
	install.packages("ape", dependencies = TRUE)     
}
if (!require( "networkD3", character.only = TRUE)) {
	install.packages("networkD3", dependencies = TRUE)     
}
if (!require( "networkD3", character.only = TRUE)) {
  install.packages("networkD3", dependencies = TRUE)     
}
#if (!require( "energy", character.only = TRUE)) {
#  install.packages("energy", dependencies = TRUE)     
#}
if (!require( "parallel", character.only = TRUE)) {
  install.packages("parallel", dependencies = TRUE)     
}




print("Build and install stylo AH:")
#file.rename("energy-master", "energy")
#system("R CMD build energy")
#install.packages("energy_1.7-8.tar.gz", repos = NULL)
file.rename("stylo-master", "stylo") #just in case
system("R CMD build stylo") #build downloaded version
install.packages("stylo_0.7.4.5.tar.gz", repos = NULL)


print("Working directory for stylo AH:")
newwd <- paste( theinstdir, "/stylo", sep="")
print( newwd )
setwd( newwd )

print("Libraries / source python libraries:")
library(reticulate)
source_python("textnorm.py")
source_python("textdecomp.py")
library(tcltk2)
library(stylo)
library(parallel)

print("Run stylo:")
stylo()
