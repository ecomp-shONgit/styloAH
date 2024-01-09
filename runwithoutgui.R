# script is usable with Rstudio
print("R Script to just start stylo Ancient History Edition without GUI.")


print("Libraries / source python libraries:")
#set working directory to source file directory
library( "rstudioapi" ) 
setwd( dirname( getActiveDocumentContext()$path ) )
print( getwd() )
library( reticulate )
source_python("textnorm.py")
source_python("textdecomp.py")
library( tcltk2 )
library( parallel )
library( transport )
library( statip )
library( styloAH )
print( "Run stylo:" )
#set working dir to sample directory (containing corpus directory AND stylo_config.txt) dir ################################################
PATHTO = "/path/to/the/dir/of/corpus/and/configfile/"
setwd( PATHTO )
print( getwd() )
stylo(gui=FALSE)


