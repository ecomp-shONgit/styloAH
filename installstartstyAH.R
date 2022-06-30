print("R Script to install/start stylo Ancient History Edition.")

thewd <- getwd()
theinstdir <- dirname(thewd)

print("Build directory for stylo AH:")
print( theinstdir )
setwd( theinstdir )

#IF OLD PACKAGES ARE INSTALLED; 
#if (require( "tcltk2", character.only = TRUE)) {
#    remove.packages("tcltk2")
#}
#if (require( "pamr", character.only = TRUE)) {
#    remove.packages("pamr")
#}
#
#if (require( "e1071", character.only = TRUE)) {
#    remove.packages("e1071")
#}
#if (require( "readr", character.only = TRUE)) {
#    remove.packages("readr")
#}
#if (require( "tsne", character.only = TRUE)) {
#    remove.packages("tsne")
#}
#if (require( "reticulate", character.only = TRUE)) {
#    remove.packages("reticulate")
#}
#
#if (require( "ape", character.only = TRUE)) {
#    remove.packages("ape")
#}
#
#if (require( "networkD3", character.only = TRUE)) {
#    remove.packages("networkD3")
#}
#
#if (require( "parallel", character.only = TRUE)) {
#    remove.packages("parallel")
#}
#
#if (require( "transport", character.only = TRUE)) {
#    remove.packages("transport")
#}
#
#if (require( "statip", character.only = TRUE)) {
#    remove.packages("statip")
#}

#update all other packages - R version
#update.packages( ask = FALSE ) 
#remove.packages( "rappdirs" )
#remove.packages( "askpass" )
#remove.packages( "lazyeval" )
#remove.packages( "purrr" )
#remove.packages( "stylo" )
#remove.packages( "styloAH" )
#remove.packages( "tidyselect" )
#DEPENDENCIES  
print("Check for / install dependancies:")
if (!require( "lazyeval", character.only = TRUE)) {
  install.packages("lazyeval", dependencies = TRUE)     
}
if (!require( "rappdirs", character.only = TRUE)) {
  install.packages("rappdirs", dependencies = TRUE)     
}
if (!require( "tcltk2", character.only = TRUE)) {
	install.packages("tcltk2", dependencies = TRUE)     
}
if (!require( "pamr", character.only = TRUE)) {
	install.packages("pamr", dependencies = TRUE)     
}
if (!require( "e1071", character.only = TRUE)) {
	install.packages("e1071", dependencies = TRUE)     
}
if (!require( "readr", character.only = TRUE)) {
	install.packages("readr", dependencies = TRUE)     
}
if (!require( "tsne", character.only = TRUE)) {
	install.packages("tsne", dependencies = TRUE)     
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
if (!require( "parallel", character.only = TRUE)) {
  install.packages("parallel", dependencies = TRUE)     
}
if (!require( "transport", character.only = TRUE)) {
  install.packages("transport", dependencies = TRUE)     
}
if (!require( "statip", character.only = TRUE)) {
  install.packages("statip", dependencies = TRUE)     
}

#check which packages are installed
installed.packages()


print("Build and install stylo AH:")
#file.rename("energy-master", "energy")
#system("R CMD build energy")
#install.packages("energy_1.7-8.tar.gz", repos = NULL)
file.rename("styloAH-master", "styloAH") #just in case
system("R CMD build styloAH") #build downloaded version
install.packages("styloAH_0.7.4.8.tar.gz", repos = NULL)


print("Working directory for stylo AH:")
newwd <- paste( theinstdir, "/styloAH", sep="")
print( newwd )
setwd( newwd )

print("Libraries / source python libraries:")
library(reticulate)
source_python("textnorm.py")
source_python("textdecomp.py")
library(tcltk2)
library(parallel)
library(transport)
library(statip)
library(styloAH)
print("Run stylo:")
stylo()
