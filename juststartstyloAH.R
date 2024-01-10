print("R Script to just start stylo Ancient History Edition.")


print("Libraries / source python libraries:")
#set working directory to source file directory
library(reticulate)
source_python("textnorm.py")
source_python("textdecomp.py")
library(tcltk2)
library(parallel)
library(transport)
library(statip)
library(styloAH)
print("Run stylo:")
#set working dir to corpus dir ???
#call stylo with arguments
stylo()
