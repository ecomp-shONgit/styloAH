print("R Script to just start stylo Ancient History Edition.")


print("Libraries / source python libraries:")
library(reticulate)
source_python("textnorm.py")
source_python("textdecomp.py")
library(tcltk2)
library(stylo)

print("Run stylo:")
stylo()
