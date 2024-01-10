print("R Script to install/start stylo Ancient History Edition.")

#set working directory to source file directory, only rstudio
print("Build directory for stylo AH:")
thewd <- getwd()
theinstdir <- dirname(thewd)
if (!require( "rstudioapi", character.only = TRUE)) {
  install.packages("rstudioapi", dependencies = TRUE)     
}
if( rstudioapi::isAvailable() == TRUE ){
  library( "rstudioapi" ) 
  theinstdir = dirname( getActiveDocumentContext()$path ) 
  setwd( theinstdir )
} else {#if on commandline or the working dir is set by hand
  setwd( theinstdir )
}
print( theinstdir )


#DEPENDENCIES  
print("Check for / install dependancies:")
if (!require( "lazyeval", character.only = TRUE)) {
  install.packages("lazyeval", dependencies = TRUE)     
}
if (!require( "rappdirs", character.only = TRUE)) {
  install.packages("rappdirs", dependencies = TRUE)     
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

print("Build and install stylo AH:")
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
library(parallel)
library(transport)
library(statip)
library(styloAH)
print("Run stylo:")
#set working dir to sample directory (containing corpus directory AND stylo_config.txt) dir 
################################################ dont use styloAH folder
PATHTO = "/path/to/folder/with/corpus/folder/in/it/"
setwd( PATHTO )
print( getwd() )
stylo(gui=FALSE)
