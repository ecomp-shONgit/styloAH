# script is usable with Rstudio
print("R Script to just start stylo Ancient History Edition without GUI.")


print("Libraries / source python libraries:")
#set working directory to source file directory
if( rstudioapi::isAvailable() ){
  library( "rstudioapi" ) 
  newwd = dirname( getActiveDocumentContext()$path ) 
  setwd( newwd )
} 
print( getwd() )
library( reticulate )
source_python("textnorm.py")
source_python("textdecomp.py")
library( parallel )
library( transport )
library( statip )
library( styloAH )
print( "Run stylo:" )
#set working dir to sample directory (containing corpus directory AND stylo_config.txt) dir 
################################################ dont use styloAH folder
PATHTO = "/path/to/folder/with/corpus/folder/in/it/"
setwd( PATHTO )
print( getwd() )
stylo(gui=FALSE)


