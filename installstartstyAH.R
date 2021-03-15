print("R Script to install/start stylo Ancient History Edition.")

thewd <- getwd()
theinstdir <- dirname(thewd)
print("Build dir for stylo:")
print( theinstdir )
setwd( theinstdir )

#DEPENDENCIES
print("Install dependancies:")
if (!require( "tcltk2", character.only = TRUE)) {
	install.packages("tcltk2", dependencies = TRUE)     
}
if (!require( "ape", character.only = TRUE)) {
	install.packages("ape", dependencies = TRUE)     
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
if (!require( "networkD3", character.only = TRUE)) {
	install.packages("networkD3", dependencies = TRUE)     
}
if (!require( "readr", character.only = TRUE)) {
	install.packages("readr", dependencies = TRUE)     
}
if (!require( "reticulate", character.only = TRUE)) {
	install.packages("reticulate", dependencies = TRUE)     
}

print("Build and install styloAH:")
file.rename("stylo-master", "stylo") #just in case
system("R CMD build stylo") #build downloaded version
install.packages("styloAH_0.7.4.1.tar.gz", repos = NULL)


print("Working sirectory for stylo:")
newwd <- paste( theinstdir, "/stylo", sep="")
print( newwd )
setwd( newwd )

print("Incl. libraries:")
library(reticulate)
source_python("textnorm.py")
library(tcltk2)
library(styloAH)

print("Run stylo:")
stylo()
