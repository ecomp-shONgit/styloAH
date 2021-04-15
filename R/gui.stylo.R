
# #################################################
# Function for displaying simple yet effective graphical interface (GUI).
# If you execute this option, the values stored in the function 
# stylo.default.settings() will serve as default for the GUI for the first run.
# In the subsequent runs, recent values will appear as default in the GUI.
# No optional arguments.
# Usage: gui.stylo()
# #################################################    

gui.stylo = function(...) {
  
  # loading required libraries
  # (this will be obsolete when we solve the varibles import/export issues)
  #  library(tcltk2)
  
  
  # using recently used settings to overwrite the default options
  restored.variables = list()
  if(file.exists("stylo_config.txt") == TRUE) {
    source("stylo_config.txt", local = TRUE) 
    # adding them on a list
    filtered.variables = ls()[!ls() %in% c("restored.variables","filtered.variables")]
    for(i in filtered.variables) {
      restored.variables[[i]] = get(i)
    }
  }
  
  
  
  # loading default settings
  default.variables = stylo.default.settings(...)
  
  # if any command-line arguments have been passed by a user, they will
  # be stored on the following list and used to overwrite the defaults
  passed.arguments = list(...)
  
  
  
  
  # Code that enables overwriting the variables with custom settings.
  # A magnificent snipped for combining two lists 
  # http://stackoverflow.com/questions/13811501/r-merge-lists-with-overwrite-and-recursion
  merge.lists <- function(a, b) {
    a.names <- names(a)
    b.names <- names(b)
    m.names <- sort(unique(c(a.names, b.names)))
    sapply(m.names, function(i) {
      if (is.list(a[[i]]) & is.list(b[[i]])) merge.lists(a[[i]], b[[i]])
      else if (i %in% b.names) b[[i]]
      else a[[i]]
    }, simplify = FALSE)
  }
  
  # if any variables have been passed as arguments, they will overwrite
  # the default settings
  variables.tmp = merge.lists(default.variables,restored.variables)
  variables = merge.lists( variables.tmp, passed.arguments )
  #print(variables)
  
  
  
  
  # #############################################################################
  # Explicit assignment of all the variables, in order to avoid attach()
  # #############################################################################
  
  add.to.margins = variables$add.to.margins
  analysis.type = variables$analysis.type
  analyzed.features = variables$analyzed.features
  analyzed.padding = variables$analyzed.padding # AHE version
  classification.method = variables$classification.method
  colors.on.graphs = variables$colors.on.graphs
  consensus.strength = variables$consensus.strength
  corpus.format = variables$corpus.format
  corpus.lang = variables$corpus.lang
  culling.incr = variables$culling.incr
  culling.max = variables$culling.max
  culling.min = variables$culling.min
  culling.of.all.samples = variables$culling.of.all.samples
  custom.graph.title = variables$custom.graph.title
  delete.pronouns = variables$delete.pronouns
  dendrogram.layout.horizontal = variables$dendrogram.layout.horizontal
  display.on.screen = variables$display.on.screen
  distance.measure = variables$distance.measure
  dump.samples = variables$dump.samples
  encoding = variables$encoding
  final.ranking.of.candidates = variables$final.ranking.of.candidates
  how.many.correct.attributions = variables$how.many.correct.attributions
  interactive.files = variables$interactive.files
  k.value = variables$k.value
  l.value = variables$l.value
  label.offset = variables$label.offset
  linkage = variables$linkage
  mfw.incr = variables$mfw.incr
  mfw.list.cutoff = variables$mfw.list.cutoff
  mfw.max = variables$mfw.max
  mfw.min = variables$mfw.min
  ngram.size = variables$ngram.size
  preserve.case = variables$preserve.case
  number.of.candidates = variables$number.of.candidates
  number.of.samples = variables$number.of.samples
  outputfile = variables$outputfile
  passed.arguments = variables$passed.arguments
  pca.visual.flavour = variables$pca.visual.flavour
  plot.custom.height = variables$plot.custom.height
  plot.custom.width = variables$plot.custom.width
  plot.font.size = variables$plot.font.size
  plot.line.thickness = variables$plot.line.thickness
  plot.options.reset = variables$plot.options.reset
  reference.wordlist.of.all.samples = variables$reference.wordlist.of.all.samples
  sample.size = variables$sample.size
  sampling = variables$sampling
  sampling.with.replacement = variables$sampling.with.replacement
  save.analyzed.features = variables$save.analyzed.features
  save.analyzed.freqs = variables$save.analyzed.freqs
  save.distance.tables = variables$save.distance.tables
  start.at = variables$start.at
  svm.coef0 = variables$svm.coef0
  svm.cost = variables$svm.cost
  svm.degree = variables$svm.degree
  svm.kernel = variables$svm.kernel
  text.id.on.graphs = variables$text.id.on.graphs
  titles.on.graphs = variables$titles.on.graphs
  txm.compatibility.mode = variables$txm.compatibility.mode
  use.custom.list.of.files = variables$use.custom.list.of.files
  use.existing.freq.tables = variables$use.existing.freq.tables
  use.existing.wordlist = variables$use.existing.wordlist
  write.jpg.file = variables$write.jpg.file
  write.pdf.file = variables$write.pdf.file
  write.png.file = variables$write.png.file
  write.svg.file = variables$write.svg.file
  z.scores.of.all.samples = variables$z.scores.of.all.samples
  
  trnom.disambidia = variables$trnom.disambidia
  trnom.repbehau = variables$trnom.repbehau
  trnom.expael = variables$trnom.expael
  trnom.translitgr = variables$trnom.translitgr
  trnom.iota = variables$trnom.iota
  trnom.alldel = variables$trnom.alldel
  trnom.numbering = variables$trnom.numbering
  trnom.ligdel = variables$trnom.ligdel
  #trnom.diadel = variables$trnom.diadel
  trnom.interdel = variables$trnom.interdel
  trnom.unkown = variables$trnom.unkown
  trnom.umbr = variables$trnom.umbr
  trnom.mak = variables$trnom.mak
  trnom.sigma = variables$trnom.sigma
  trnom.klam = variables$trnom.klam
  trnom.uv = variables$trnom.uv
  trnom.ji = variables$trnom.ji
  trnom.hyph = variables$trnom.hyph
  trnom.alphapriv = variables$trnom.alphapriv
  # #############################################################################
  
  
  
  
  
  # a not very elegant way of switching from strings into logical values
  encoding.orig = variables$encoding
  if(variables$encoding == "UTF-8") {
    encoding = FALSE
  } else {
    encoding = TRUE
  }
  
  
  
  
  
  .Tcl("font create myDefaultFont -family tahoma -size 8")
  .Tcl("option add *font myDefaultFont")  
  
  tt <- tktoplevel()
  tktitle(tt) <- "Stylometry with R (AH edition) | stylo | set parameters"
  
  
  
  # Create a variable to keep track of the state of the dialog window:
  #   If the window is active,                                      done = 0
  #   If the window has been closed using the OK button,            done = 1
  
  done <- tclVar(0)
  
  
  push_OK <- function(){
    tkdestroy(tt)
    tclvalue(done) = 1
  }
  
  #TEXT NORM VARS
  
  #disambiguDIAkritika( string ) #String replaced of diakrit
  trnom.disambidia <- tclVar(trnom.disambidia)
  
  #replaceBehauchung( adiakstring ) # replaces behauchung in the transliteration of greek to latin
  trnom.repbehau <- tclVar(trnom.repbehau)
  
  #Expandelision( aword ) # given a word, if this is an elusion it will be expanded
  trnom.expael <- tclVar(trnom.expael)
  
  #TraslitAncientGreekLatin( astring ) # takes greek utf8 string and returns transliterated latin utf8 string
  trnom.translitgr <- tclVar(trnom.translitgr)
  
  #iotasubiotoad( aword ) # takes greek utf8 string and repleces jota subscriptum with jota ad scriptum
  trnom.iota <- tclVar(trnom.iota)
  
  #delall( text ) #deletes UV, klammern, sigma, grkl, umbrüche, ligaturen, interpunktion, edition numbering, unknown signs, diakritika
  trnom.alldel <- tclVar(trnom.alldel)
  
  #delnumbering( text ) #takes string return string without the edition numbering i.e. [2]
  trnom.numbering <- tclVar(trnom.numbering)
  
  #delligaturen( text ) # takes a string return string with ligatures turned to single letters
  trnom.ligdel <- tclVar(trnom.ligdel)
  
  #deldiak( text ) #like nodiakinword()
  #trnom.diadel <- tclVar(trnom.diadel)
  
  #delinterp( text ) #takes string and returns the string without
  trnom.interdel <- tclVar(trnom.interdel)
  
  #delunknown( text ) # delete some to the programmer unknown signs
  trnom.unkown <- tclVar(trnom.unkown)
  
  #delumbrbine( text ) # input string and get it back with linebreaks removed
  trnom.umbr <- tclVar(trnom.umbr)
  
  #delmakup( text ) #input a string and get it pack with markup removed
  trnom.mak <- tclVar(trnom.mak)
  
  #sigmaistgleich( text ) #equalize tailing sigma
  trnom.sigma <- tclVar(trnom.sigma)
  
  #delklammern( text ) # input stringa nd get it back with no brackets
  trnom.klam <- tclVar(trnom.klam)
  
  #deluv( text ) # repaces all u with v
  trnom.uv <- tclVar(trnom.uv)
  
  #delji( text ) # replace all j with i
  trnom.ji <- tclVar(trnom.ji)
  
  #Trennstricheraus( array of words ) #input array of words removes hyphenation
  trnom.hyph <- tclVar(trnom.hyph)
  
  #
  trnom.alphapriv <- tclVar(trnom.alphapriv)
  
  #STYLO VARS
  
  corpus.format <- tclVar(corpus.format)
  mfw.min <- tclVar(mfw.min)
  mfw.max <- tclVar(mfw.max)
  mfw.incr <- tclVar(mfw.incr)
  start.at <- tclVar(start.at)
  culling.min <- tclVar(culling.min)
  culling.max <- tclVar(culling.max)
  culling.incr <- tclVar(culling.incr)
  ngram.size <- tclVar(ngram.size)
  preserve.case <- tclVar(preserve.case)
  analyzed.features <- tclVar(analyzed.features)
  analyzed.padding <- tclVar(analyzed.padding)
  use.existing.freq.tables <- tclVar(use.existing.freq.tables)
  use.existing.wordlist <- tclVar(use.existing.wordlist)
  interactive.files <- tclVar(interactive.files)
  use.custom.list.of.files <- tclVar(use.custom.list.of.files)
  mfw.list.cutoff <- tclVar(mfw.list.cutoff)
  analysis.type <- tclVar(analysis.type)
  delete.pronouns <- tclVar(delete.pronouns)
  corpus.lang <- tclVar(corpus.lang)
  distance.measure <- tclVar(distance.measure)
  display.on.screen <- tclVar(display.on.screen)
  write.pdf.file <- tclVar(write.pdf.file)
  write.jpg.file <- tclVar(write.jpg.file)
  write.svg.file <- tclVar(write.svg.file)
  write.png.file <- tclVar(write.png.file)
  colors.on.graphs <- tclVar(colors.on.graphs)
  titles.on.graphs <- tclVar(titles.on.graphs)
  dendrogram.layout.horizontal <- tclVar(dendrogram.layout.horizontal)
  pca.visual.flavour <- tclVar(pca.visual.flavour)
  save.distance.tables <- tclVar(save.distance.tables)
  save.analyzed.features <- tclVar(save.analyzed.features)
  save.analyzed.freqs <- tclVar(save.analyzed.freqs)
  sampling <- tclVar(sampling)
  sample.size <- tclVar(sample.size)
  number.of.samples <- tclVar(number.of.samples)
  consensus.strength <- tclVar(consensus.strength)
  plot.options.reset <- tclVar(plot.options.reset)
  plot.custom.height <- tclVar(plot.custom.height)
  plot.custom.width <- tclVar(plot.custom.width)
  plot.font.size <- tclVar(plot.font.size)
  plot.line.thickness <- tclVar(plot.line.thickness)
  text.id.on.graphs <- tclVar(text.id.on.graphs)
  add.to.margins <- tclVar(add.to.margins)
  label.offset <- tclVar(label.offset)
  dump.samples <- tclVar(dump.samples)
  encoding <- tclVar(encoding)
  
  
  
  f1 <- tkframe(tt)
  f2 <- tkframe(tt)
  f3 <- tkframe(tt)
  f4 <- tkframe(tt)
  f5 <- tkframe(tt)
  f6 <- tkframe(tt)
  
  # layout of the GUI begins here:
  tab1 <- function() {
    tkgrid(f1,row=1,column=0,columnspan=5)
    tkgrid.forget(f2)
    tkgrid.forget(f3)
    tkgrid.forget(f4)
    tkgrid.forget(f5)
    tkgrid.forget(f6)
    tkconfigure(t1.but,state="disabled", background="white")
    tkconfigure(t2.but,state="normal", background="aliceblue")
    tkconfigure(t3.but,state="normal", background="aliceblue")
    tkconfigure(t4.but,state="normal", background="aliceblue")
    tkconfigure(t5.but,state="normal", background="aliceblue")
    tkconfigure(t6.but,state="normal", background="aliceblue")
  }
  tab2 <- function() {
    tkgrid(f2,row=1,column=0,columnspan=5)
    tkgrid.forget(f1)
    tkgrid.forget(f3)
    tkgrid.forget(f4)
    tkgrid.forget(f5)
    tkgrid.forget(f6)
    tkconfigure(t2.but,state="disabled", background="white")
    tkconfigure(t1.but,state="normal", background="aliceblue")
    tkconfigure(t3.but,state="normal", background="aliceblue")
    tkconfigure(t4.but,state="normal", background="aliceblue")
    tkconfigure(t5.but,state="normal", background="aliceblue")
    tkconfigure(t6.but,state="normal", background="aliceblue")
  }
  tab3 <- function() {
    tkgrid(f3,row=1,column=0,columnspan=5)
    tkgrid.forget(f1)
    tkgrid.forget(f2)
    tkgrid.forget(f4)
    tkgrid.forget(f5)
    tkgrid.forget(f6)
    tkconfigure(t3.but,state="disabled", background="white")
    tkconfigure(t1.but,state="normal", background="aliceblue")
    tkconfigure(t2.but,state="normal", background="aliceblue")
    tkconfigure(t4.but,state="normal", background="aliceblue")
    tkconfigure(t5.but,state="normal", background="aliceblue")
    tkconfigure(t6.but,state="normal", background="aliceblue")
  }
  tab4 <- function() {
    tkgrid(f4,row=1,column=0,columnspan=5)
    tkgrid.forget(f1)
    tkgrid.forget(f2)
    tkgrid.forget(f3)
    tkgrid.forget(f5)
    tkgrid.forget(f6)
    tkconfigure(t4.but,state="disabled", background="white")
    tkconfigure(t1.but,state="normal", background="aliceblue")
    tkconfigure(t2.but,state="normal", background="aliceblue")
    tkconfigure(t3.but,state="normal", background="aliceblue")
    tkconfigure(t5.but,state="normal", background="aliceblue")
    tkconfigure(t6.but,state="normal", background="aliceblue")
  }
  tab5 <- function() {
    tkgrid(f5,row=1,column=0,columnspan=5)
    tkgrid.forget(f1)
    tkgrid.forget(f2)
    tkgrid.forget(f3)
    tkgrid.forget(f4)
    tkgrid.forget(f6)
    tkconfigure(t5.but,state="disabled", background="white")
    tkconfigure(t1.but,state="normal", background="aliceblue")
    tkconfigure(t2.but,state="normal", background="aliceblue")
    tkconfigure(t3.but,state="normal", background="aliceblue")
    tkconfigure(t4.but,state="normal", background="aliceblue")
    tkconfigure(t6.but,state="normal", background="aliceblue")
  }
  tab6 <- function() {
    tkgrid(f6,row=1,column=0,columnspan=5)
    tkgrid.forget(f1)
    tkgrid.forget(f2)
    tkgrid.forget(f3)
    tkgrid.forget(f4)
    tkgrid.forget(f5)
    tkconfigure(t6.but,state="disabled", background="white")
    tkconfigure(t1.but,state="normal", background="aliceblue")
    tkconfigure(t2.but,state="normal", background="aliceblue")
    tkconfigure(t3.but,state="normal", background="aliceblue")
    tkconfigure(t4.but,state="normal", background="aliceblue")
    tkconfigure(t5.but,state="normal", background="aliceblue")
  }
  t1.but <- tkbutton(tt,text="     INPUT & LANGUAGE     ",command=tab1)
  t2.but <- tkbutton(tt,text="         FEATURES         ",command=tab2)
  t3.but <- tkbutton(tt,text="        STATISTICS        ",command=tab3)
  t4.but <- tkbutton(tt,text="         SAMPLING         ",command=tab4)
  t5.but <- tkbutton(tt,text="          OUTPUT          ",command=tab5)
  t6.but <- tkbutton(tt,text="       NORMALIZATION      ",command=tab6)
  
  tkgrid(t1.but)
  tkgrid(t2.but, column=1, row=0)
  tkgrid(t3.but, column=2, row=0)
  tkgrid(t4.but, column=3, row=0)
  tkgrid(t5.but, column=4, row=0)
  tkgrid(t6.but, column=5, row=0)
  # Grid for individual tabs
  
  # initial state!
  tkgrid(f1,row=1,column=0,columnspan=5)
  tkconfigure(t1.but,state="disabled", background="white")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  tkconfigure(t6.but,state="normal", background="aliceblue")
  
  
  # the OK button: active on each tab
  #
  button_1 <- tkbutton(tt,text="       OK       ",command=push_OK,relief="raised",background="aliceblue")
  tkbind(button_1,"<Return>",push_OK)
  tkgrid(button_1,columnspan=10)
  tk2tip(button_1, "Press this only if you've visited all the tabs, or if you know\nyou want to leave values in some as they are.")
  
  
  ########################################################################################################################
  # layout of the GUI begins here:
  #
  tkgrid(tklabel(f1,text="    "),padx=0,pady=0) # blank line (serving as the top margin)
  tkgrid(tklabel(f2,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f3,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f4,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f5,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f6,text="    ")) # blank line (serving as the top margin)
  
  # first row: INPUT
  #
  entry_TXT <- tkradiobutton(f1)
  entry_XML <- tkradiobutton(f1)
  entry_XMLDrama <- tkradiobutton(f1)
  entry_XMLNoTitles <- tkradiobutton(f1)
  entry_HTML <- tkradiobutton(f1)
  #
  tkconfigure(entry_TXT,variable=corpus.format,value="plain")
  tkconfigure(entry_XML,variable=corpus.format,value="xml")
  tkconfigure(entry_XMLDrama,variable=corpus.format,value="xml.drama")
  tkconfigure(entry_XMLNoTitles,variable=corpus.format,value="xml.notitles")
  tkconfigure(entry_HTML,variable=corpus.format,value="html")
  #
  entrylabel_TXT <- tklabel(f1,text="plain text")
  entrylabel_XML <- tklabel(f1,text="xml")
  entrylabel_XMLDrama <- tklabel(f1,text="xml (plays)")
  entrylabel_XMLNoTitles <- tklabel(f1,text="xml (no titles)")
  entrylabel_HTML <- tklabel(f1,text="html")
  #
  tkgrid(tklabel(f1,text="       INPUT:"),entrylabel_TXT,entrylabel_XML,entrylabel_XMLDrama,entrylabel_XMLNoTitles,entrylabel_HTML,columnspan=1)
  tkgrid(tklabel(f1,text="            "),entry_TXT,entry_XML,entry_XMLDrama,entry_XMLNoTitles,entry_HTML,columnspan=1)
  # Tooltips for the above
  tk2tip(entrylabel_TXT, "Plain text files. \nIf your corpus does not contain diacritics, no encoding is needed. \nOtherwise, use ANSI for Windows, UTF-8 for Mac/Linux.")
  tk2tip(entrylabel_XML, "XML: all tags and TEI headers are removed.")
  tk2tip(entrylabel_XMLDrama, "XML for plays: all tags, TEI headers, \nand speakers' names between <speaker>...</speaker> tags are removed.")
  tk2tip(entrylabel_XMLNoTitles, "XML contents only: all tags, TEI headers, \nand chapter/section (sub)titles between <head>...</head> tags are removed.")
  tk2tip(entrylabel_HTML, "HTML headers, menus, links and other tags are removed.")
  tkgrid(tklabel(f1,text="    ")) # blank line for aesthetic purposes
  
  # next row: LANGUAGE
  #
  entry_ENG <- tkradiobutton(f1)
  entry_EN2 <- tkradiobutton(f1)
  entry_EN3 <- tkradiobutton(f1)
  entry_POL <- tkradiobutton(f1)
  entry_LAT <- tkradiobutton(f1)
  entry_LA2 <- tkradiobutton(f1)
  entry_FRA <- tkradiobutton(f1)
  entry_GER <- tkradiobutton(f1)
  entry_HUN <- tkradiobutton(f1)
  entry_ITA <- tkradiobutton(f1)
  entry_DUT <- tkradiobutton(f1)
  entry_SPA <- tkradiobutton(f1)
  entry_CJK <- tkradiobutton(f1)
  entry_OTH <- tkradiobutton(f1)
  cb_UTF <- tkcheckbutton(f1)
  
  #
  tkconfigure(entry_ENG,variable=corpus.lang,value="English")
  tkconfigure(entry_EN2,variable=corpus.lang,value="English.contr")
  tkconfigure(entry_EN3,variable=corpus.lang,value="English.all")
  tkconfigure(entry_LAT,variable=corpus.lang,value="Latin")
  tkconfigure(entry_LA2,variable=corpus.lang,value="Latin.corr")
  tkconfigure(entry_POL,variable=corpus.lang,value="Polish")
  tkconfigure(entry_FRA,variable=corpus.lang,value="French")
  tkconfigure(entry_GER,variable=corpus.lang,value="German")
  tkconfigure(entry_HUN,variable=corpus.lang,value="Hungarian")
  tkconfigure(entry_ITA,variable=corpus.lang,value="Italian")
  tkconfigure(entry_DUT,variable=corpus.lang,value="Dutch")
  tkconfigure(entry_SPA,variable=corpus.lang,value="Spanish")
  tkconfigure(entry_CJK,variable=corpus.lang,value="CJK")
  tkconfigure(entry_OTH,variable=corpus.lang,value="Other")
  tkconfigure(cb_UTF,variable=encoding)
  
  #
  entrylabel_ENG <- tklabel(f1,text="    English     ")
  entrylabel_POL <- tklabel(f1,text="    Polish      ")
  entrylabel_LAT <- tklabel(f1,text="    Latin       ")
  entrylabel_FRA <- tklabel(f1,text="    French      ")
  entrylabel_GER <- tklabel(f1,text="    German      ")
  entrylabel_HUN <- tklabel(f1,text="   Hungarian    ")
  entrylabel_ITA <- tklabel(f1,text="    Italian     ")
  entrylabel_EN2 <- tklabel(f1,text="English (contr.)")
  entrylabel_EN3 <- tklabel(f1,text="  English (ALL) ")
  entrylabel_LA2 <- tklabel(f1,text="Latin (u/v > u) ")
  entrylabel_DUT <- tklabel(f1,text="     Dutch      ")
  entrylabel_SPA <- tklabel(f1,text="    Spanish     ")
  entrylabel_CJK <- tklabel(f1,text="      CJK       ")
  entrylabel_OTH <- tklabel(f1,text="     Other      ")
  entrylabel_UTF <- tklabel(f1,text="     Native encoding      ")
  
  #
  tkgrid(tklabel(f1,text="LANGUAGE: "),entrylabel_ENG,entrylabel_EN2,entrylabel_EN3,entrylabel_LAT,entrylabel_LA2)
  tkgrid(tklabel(f1,text="          "),entry_ENG,entry_EN2,entry_EN3,entry_LAT,entry_LA2)
  tkgrid(tklabel(f1,text="          "),entrylabel_POL,entrylabel_HUN,entrylabel_FRA,entrylabel_ITA,entrylabel_SPA)
  tkgrid(tklabel(f1,text="          "),entry_POL,entry_HUN,entry_FRA,entry_ITA,entry_SPA)
  tkgrid(tklabel(f1,text="          "),entrylabel_DUT,entrylabel_GER, entrylabel_CJK, entrylabel_OTH,tklabel(f1,text=""),entrylabel_UTF)
  tkgrid(tklabel(f1,text="          "),entry_DUT,entry_GER, entry_CJK, entry_OTH,tklabel(f1,text=""),cb_UTF)
  tkgrid(tklabel(f1,text="          "))
  tkgrid(tklabel(f1,text="          "))
  tkgrid(tklabel(f1,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_ENG, "Plain English: contractions and \ncompound words are split")
  tk2tip(entrylabel_POL, "Plain Polish: contractions and \ncompound words are split")
  tk2tip(entrylabel_EN2, "Modified English: \ncontractions are not split")
  tk2tip(entrylabel_EN3, "Further Modified English: contractions \nand compound words are not split")
  tk2tip(entrylabel_LAT, "Plain Latin: U and V \ntreated as distinct letters")
  tk2tip(entrylabel_FRA, "Plain French: contractions and \ncompound words are split")
  tk2tip(entrylabel_GER, "Plain German: contractions and \ncompound words are split")
  tk2tip(entrylabel_HUN, "Plain Hungarian: contractions and \ncompound words are split")
  tk2tip(entrylabel_ITA, "Plain Italian: contractions and \ncompound words are split")
  tk2tip(entrylabel_LA2, "Modified Latin: U and V \nboth treated as U")
  tk2tip(entrylabel_DUT, "Plain Dutch: contractions and \ncompound words are split")
  tk2tip(entrylabel_SPA, "Plain Castilian: contractions and \ncompound words are split")
  tk2tip(entrylabel_CJK, "Chinese, Japanese and Korean \n(experimental)")
  tk2tip(entrylabel_OTH, "Other language than the ones listed above.")
  tk2tip(entrylabel_UTF, "Check this box if your texts are in a \nnative encoding other than UTF-8. \n(May apply on Windows machines.) \nUse the function check_encoding() \nif you are uncertain.")
  
  
  
  # next row: TEXT FEATURES
  entry_W <- tkradiobutton(f2)
  entry_L <- tkradiobutton(f2)
  entry_WLC <- tkradiobutton(f2)
  cb_NGRAMS <- tkcheckbutton(f2)
  entry_NGRAMSIZE <- tkentry(f2,textvariable=ngram.size,width="8")
  cb_PRESERVECASE <- tkcheckbutton(f2)
  cb_PADDING <- tkcheckbutton(f2)
  #
  tkconfigure(entry_W,variable=analyzed.features,value="w")
  tkconfigure(entry_L,variable=analyzed.features,value="c")
  tkconfigure(entry_WLC,variable=analyzed.features,value="wlc")
  tkconfigure(cb_PRESERVECASE,variable=preserve.case)
  tkconfigure(cb_PRESERVECASE,variable=analyzed.padding)
  #
  entrylabel_W <- tklabel(f2,text="words")
  entrylabel_L <- tklabel(f2,text="chars")
  ntrylabel_WLC <- tklabel(f2,text="w.l.c.")
  entrylabel_NGRAMSIZE <- tklabel(f2,text="ngram size")
  entrylabel_PRESERVECASE <- tklabel(f2,text="preserve case")
  entrylabel_Padd <- tklabel(f2,text="padding")
  #
  tkgrid(tklabel(f2,text="        FEATURES:"),entrylabel_W,entrylabel_L,ntrylabel_WLC,entrylabel_NGRAMSIZE, entrylabel_PRESERVECASE, entrylabel_Padd)
  tkgrid(tklabel(f2,text="                 "),entry_W,entry_L,entry_WLC,entry_WLC,entry_NGRAMSIZE, cb_PRESERVECASE, cb_PADDING)

  
  # Tooltips for the above
  tk2tip(entrylabel_W, "Select this to work on words")
  tk2tip(entrylabel_L, "Select this to work on characters \n(does not make much sense unless you use ngrams)")
  tk2tip(entrylabel_NGRAMSIZE, "State your n for n-grams \nto work on word/char clusters of n")
  tk2tip(entrylabel_PRESERVECASE, "Whether or not to lowercase all characters")
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
  
  # next row: OTHER Features realy
  eof1 <- tkradiobutton(f2)
  eof2 <- tkradiobutton(f2)
  eof3 <- tkradiobutton(f2)
  eof4 <- tkradiobutton(f2)
  eof5 <- tkradiobutton(f2)
  eof6 <- tkradiobutton(f2)
  eof7 <- tkradiobutton(f2)
  eof8 <- tkradiobutton(f2)
   
  
  tkconfigure(eof1,variable=analyzed.features,value="sepdia")
  tkconfigure(eof2,variable=analyzed.features,value="woc")
  tkconfigure(eof3,variable=analyzed.features,value="wov")
  tkconfigure(eof4,variable=analyzed.features,value="smw")
  tkconfigure(eof5,variable=analyzed.features,value="bw")
  tkconfigure(eof6,variable=analyzed.features,value="syl")
  tkconfigure(eof7,variable=analyzed.features,value="hbc1")
  tkconfigure(eof8,variable=analyzed.features,value="hbc2")

  eof1_l <- tklabel(f2,text="sep. diac.")
  eof2_l <- tklabel(f2,text="no consonants")
  eof3_l <- tklabel(f2,text="no vovels")
  eof4_l <- tklabel(f2,text="small words")
  eof5_l <- tklabel(f2,text="big words")
  eof6_l <- tklabel(f2,text="pseudo syllables")
  eof7_l <- tklabel(f2,text="head-body-coda")
  eof8_l <- tklabel(f2,text="all partitions")

  tkgrid(tklabel(f2,text="  Other FEATURES:"), eof1_l, eof2_l, eof3_l, eof4_l)
  tkgrid(tklabel(f2,text="                 "), eof1,eof2,eof3,eof4)
  tkgrid(tklabel(f2,text="                 "), eof5_l, eof6_l, eof7_l, eof8_l)
  tkgrid(tklabel(f2,text="                 "), eof5,eof6,eof7,eof8)
  # next row: MFW SETTINGS
  #
  entry_MFW_MIN <- tkentry(f2,textvariable=mfw.min,width="8")
  entry_MFW_MAX <- tkentry(f2,textvariable=mfw.max,width="8")
  entry_MFW_INCR <- tkentry(f2,textvariable=mfw.incr,width="8")
  entry_START_AT <- tkentry(f2,textvariable=start.at,width="8")
  #
  entrylabel_MFW_MIN <- tklabel(f2,text="Minimum")
  entrylabel_MFW_MAX <- tklabel(f2,text="Maximum")
  entrylabel_MFW_INCR <- tklabel(f2,text="Increment")
  entrylabel_START_AT <- tklabel(f2,text="Start at freq. rank")
  #
  tkgrid(tklabel(f2,text="MFW SETTINGS:"),entrylabel_MFW_MIN,entrylabel_MFW_MAX,entrylabel_MFW_INCR,entrylabel_START_AT)
  tkgrid(tklabel(f2,text="             "),entry_MFW_MIN,entry_MFW_MAX,entry_MFW_INCR,entry_START_AT)
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_MFW_MIN, "Set the minimum number of most frequent words. \nThe script will conduct its first analysis for \nthe number of words specified here")
  tk2tip(entrylabel_MFW_MAX, "Set the maximum number of most frequent words. \nThe script will conduct its final analysis for \nthe number of words specified here")
  tk2tip(entrylabel_MFW_INCR, "Set the increment added to \nthe minimum number of most frequent \nwords for each subsequent analysis.")
  tk2tip(entrylabel_START_AT, "Set the number of words from the top of \nthe frequency list to skip in the analysis.")
  
  # next row: CULLING
  #
  cb_DEL_PRON <- tkcheckbutton(f2)
  #
  entry_CUL_MIN <- tkentry(f2,textvariable=culling.min,width="8")
  entry_CUL_MAX <- tkentry(f2,textvariable=culling.max,width="8")
  entry_CUL_INCR <- tkentry(f2,textvariable=culling.incr,width="8")
  entry_CUT_OFF <- tkentry(f2,textvariable=mfw.list.cutoff,width="8")
  tkconfigure(cb_DEL_PRON,variable=delete.pronouns)
  #
  entrylabel_CUL_MIN <- tklabel(f2,text="Minimum")
  entrylabel_CUL_MAX <- tklabel(f2,text="Maximum")
  entrylabel_CUL_INCR <- tklabel(f2,text="Increment")
  entrylabel_CUT_OFF <- tklabel(f2,text="List Cutoff")
  cblabel_DEL_PRON <- tklabel(f2,text="Delete pronouns")
  #
  tkgrid(tklabel(f2,text="         CULLING:"),entrylabel_CUL_MIN,entrylabel_CUL_MAX, entrylabel_CUL_INCR,entrylabel_CUT_OFF,cblabel_DEL_PRON)
  tkgrid(tklabel(f2,text="                 "),entry_CUL_MIN,entry_CUL_MAX,entry_CUL_INCR,entry_CUT_OFF,cb_DEL_PRON)
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
  
  
  # next row: LISTS & FILES
  #
  cb_FREQS <- tkcheckbutton(f2)
  cb_LISTS <- tkcheckbutton(f2)
  cb_INTFILES <- tkcheckbutton(f2)
  cb_MYFILES <- tkcheckbutton(f2)
  #
  tkconfigure(cb_FREQS,variable=use.existing.freq.tables)
  tkconfigure(cb_LISTS,variable=use.existing.wordlist)
  tkconfigure(cb_INTFILES,variable=interactive.files)
  tkconfigure(cb_MYFILES,variable=use.custom.list.of.files)
  #
  cblabel_FREQS <- tklabel(f2,text="Existing frequencies")
  cblabel_LISTS <- tklabel(f2,text="Existing wordlist")
  cblabel_INTFILES <- tklabel(f2,text="Select files manually")
  cblabel_MYFILES <- tklabel(f2,text="List of files")
  #
  tkgrid(tklabel(f2,text="    VARIOUS:"),cblabel_FREQS,cblabel_LISTS,cblabel_INTFILES,cblabel_MYFILES)
  tkgrid(tklabel(f2,text="            "),cb_FREQS,cb_LISTS,cb_INTFILES,cb_MYFILES)
  
  # Tooltips for the above  
  tk2tip(entrylabel_CUL_MIN, "State the minimum culling setting. \n0 means no words are omitted from the analysis. \n50 means a word needs to appear in \nat least 50% of the texts to be included in the analysis. \n100 means that only words appearing in all the texts \nwill be included in the analysis")
  tk2tip(entrylabel_CUL_MAX, "State the maximum culling setting. \n0 means no words are omitted from the analysis. \n50 means a word needs to appear in \nat least 50% of the texts to be included in the analysis. \n100 means that only words appearing in all the texts \nwill be included in the analysis")
  tk2tip(entrylabel_CUL_INCR, "State the increment added to the minimum culling \nsetting for each subsequent analysis.")
  tk2tip(entrylabel_CUT_OFF, "Set the maximum size of the word frequency table. \nAnything above 5000 requires patience and a fast computer")
  tk2tip(cblabel_DEL_PRON, "Select if you want to omit pronouns in the analysis. \nThis improves attribution in some languages")
  tk2tip(cblabel_FREQS, "Select to use the frequency lists generated by the previous analysis. \nThis speeds up the process dramatically. \nA very bad idea if you've just changed your selection of texts!")
  tk2tip(cblabel_LISTS, "Select to use the wordlist generated by \nthe previous analysis or a custom wordlist.")
  tk2tip(cblabel_INTFILES, "Select this to manually select files \nrather than use the entire corpus. \nMake sure that \"Existing frequencies\" is unchecked!")
  tk2tip(cblabel_MYFILES, "Select this if you want to use custom list \nof files to be loaded; the list should be stored \nin \"files_to_analyze.txt\", and the entries delimited \nwith spaces, tabs, or newlines.")
  
  
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes 
  
  # next row: STATISTICS
  #
  entry_CA <- tkradiobutton(f3)
  entry_MDS <- tkradiobutton(f3)
  entry_PCA1 <- tkradiobutton(f3)
  entry_PCA2 <- tkradiobutton(f3)
  entry_CONS_TREE <- tkradiobutton(f3)
  entry_tSNE <- tkradiobutton(f3)
  entry_CONSS <- tkentry(f3,textvariable=consensus.strength,width="8")
  #
  tkconfigure(entry_CA,variable=analysis.type,value="CA") # cluster.analysis
  tkconfigure(entry_MDS,variable=analysis.type,value="MDS") # multidimensional.scaling
  tkconfigure(entry_PCA1,variable=analysis.type,value="PCV") # pca.covariance.table
  tkconfigure(entry_PCA2,variable=analysis.type,value="PCR") # pca.correlation.table
  tkconfigure(entry_CONS_TREE,variable=analysis.type,value="BCT") # make.consensus.tree
  tkconfigure(entry_tSNE,variable=analysis.type,value="tSNE") # make.tSNE
  
  #
  entrylabel_CA <- tklabel(f3,text="Cluster Analysis")
  entrylabel_MDS <- tklabel(f3,text="MDS")
  entrylabel_PCA1 <- tklabel(f3,text="PCA (cov.)")
  entrylabel_PCA2 <- tklabel(f3,text="PCA (corr.)")
  entrylabel_tSNE <- tklabel(f3,text="     tSNE ")
  entrylabel_CONS_TREE <- tklabel(f3,text="Consensus Tree")
  entrylabel_CONSS <- tklabel(f3,text="Consensus strength")
  #
  tkgrid(tklabel(f3,text=" STATISTICS:"),entrylabel_CA,entrylabel_MDS,entrylabel_PCA1,entrylabel_PCA2,entrylabel_tSNE)
  tkgrid(tklabel(f3,text="            "),entry_CA,entry_MDS,entry_PCA1,entry_PCA2, entry_tSNE)
  tkgrid(tklabel(f3,text="            "),entrylabel_CONS_TREE,entrylabel_CONSS)
  tkgrid(tklabel(f3,text="            "),entry_CONS_TREE,entry_CONSS)
  
  # Tooltips for the above
  tk2tip(entrylabel_CA, "Select to perform Cluster Analysis of Delta distance table. \nThis only makes sense if there is a single iteration \n(or only a few), so set MFW_MIN and MFW_MAX \nto equal values, which in turn makes the MFW_INCR setting immaterial. \nThen do the same for your culling settings.")
  tk2tip(entrylabel_MDS, "Select to perform Multidimensional Scaling of Delta distance table. \nThis only makes sense if there is a single iteration \n(or only a few), so set MFW_MIN and MFW_MAX \nto equal values, which in turn makes the MFW_INCR setting immaterial. \nThen do the same for your culling settings.")
  tk2tip(entrylabel_PCA1, "Select to perform Principal Components Analysis based on a covariance matrix of feature frequencies. \nThis only makes sense if there is a single iteration (or only a few), so set MFW_MIN and MFW_MAX \nto equal values, which in turn makes the MFW_INCR setting immaterial. \nThen do the same for your culling settings.")
  tk2tip(entrylabel_PCA2, "Select to perform Principal Components Analysis based on a correlation matrix of feature frequencies. \nThis only makes sense if there is a single iteration (or only a few), so set MFW_MIN and MFW_MAX \nto equal values, which in turn makes the MFW_INCR setting immaterial. \nThen do the same for your culling settings.")
  tk2tip(entrylabel_tSNE, "Select to perform a tSNE visualization (t-Distributed Stochastic Neighbor Embedding).\nThis only makes sense if there is a single iteration (or perhaps a few), so set MFW_MIN and MFW_MAX \nto equal values, which in turn makes the MFW_INCR setting immaterial. \nThen do the same for your culling settings.")
  tk2tip(entrylabel_CONS_TREE, "Select to perform multiple iterations of Cluster Analysis of Delta distance table \nresulting in a Bootstrap COnsensus Tree. This only makes sense \nif you have at least three valid iterations, so set MFW_MIN and MFW_MAX, \nand/or CUL_MIN and CUL_MAX to different values.")
  tk2tip(entrylabel_CONSS, "Select to set the consensus strength for the Bootstrap Tree. \nOnly makes sense if you select that option is checked above. \nLegal values are from 0.4 (40% underlying CA graphs need to agree \non a given connection) to 1 (all underlying CA graphs need to agree).")
  
  
  # next row: DISTANCES
  #
  entry_CD <- tkradiobutton(f3)
  entry_WD <- tkradiobutton(f3)
  entry_ED <- tkradiobutton(f3)
  entry_ES <- tkradiobutton(f3)
  entry_EN <- tkradiobutton(f3)
  entry_MH <- tkradiobutton(f3)
  entry_CB <- tkradiobutton(f3)
  entry_EU <- tkradiobutton(f3)
  entry_CS <- tkradiobutton(f3)
  entry_MM <- tkradiobutton(f3)
  
  #
  tkconfigure(entry_CD,variable=distance.measure,value="delta")
  tkconfigure(entry_WD,variable=distance.measure,value="wurzburg")
  tkconfigure(entry_ED,variable=distance.measure,value="eder")
  tkconfigure(entry_ES,variable=distance.measure,value="simple")
  tkconfigure(entry_EN,variable=distance.measure,value="entropy")
  tkconfigure(entry_MH,variable=distance.measure,value="manhattan")
  tkconfigure(entry_CB,variable=distance.measure,value="canberra")
  tkconfigure(entry_EU,variable=distance.measure,value="euclidean")
  tkconfigure(entry_CS,variable=distance.measure,value="cosine")
  tkconfigure(entry_MM,variable=distance.measure,value="minmax")
  #
  entrylabel_CD <- tklabel(f3,text="Classic Delta")
  entrylabel_WD <- tklabel(f3,text="Cosine Delta")
  entrylabel_ED <- tklabel(f3,text="Eder's Delta")
  entrylabel_ES <- tklabel(f3,text="Eder's Simple")
  entrylabel_EN <- tklabel(f3,text="Entropy")
  entrylabel_MH <- tklabel(f3,text="Manhattan")
  entrylabel_CB <- tklabel(f3,text="Canberra")
  entrylabel_EU <- tklabel(f3,text="Euclidean")
  entrylabel_CS <- tklabel(f3,text="Cosine")
  entrylabel_MM <- tklabel(f3,text="Min-Max")
  #
  tkgrid(tklabel(f3,text="  DELTA DISTANCE:  "),entrylabel_CD,entrylabel_WD,entrylabel_ED,entrylabel_ES,entrylabel_EN)
  tkgrid(tklabel(f3,text="            "),entry_CD,entry_WD,entry_ED,entry_ES,entry_EN)
  tkgrid(tklabel(f3,text="            "),entrylabel_MH,entrylabel_CB,entrylabel_EU,entrylabel_CS,entrylabel_MM)
  tkgrid(tklabel(f3,text="            "),entry_MH,entry_CB,entry_EU,entry_CS,entry_MM)
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_CD, "Select the Classic Delta measure as introduced by Burrows.")
  tk2tip(entrylabel_WD, "Select Cosine Delta (aka Wurzburg Delta), which seems to outperform other measures.")
  tk2tip(entrylabel_ED, "Select Eder's Delta (weights the frequencies, in order to decrease the influence of the less frequent words).")
  tk2tip(entrylabel_ES, "Select Eder's Simple measure (the frequencies are transformed via square root).")
  tk2tip(entrylabel_EN, "Select Entropy Delta, or Manhattan appied to entropy-transformed dataset.")
  tk2tip(entrylabel_MH, "Select Manhattan Distance (obvious and well documented).")
  tk2tip(entrylabel_CB, "Select Canberra Distance (risky, but sometimes amazingly good).")
  tk2tip(entrylabel_EU, "Select Euclidean Distance (basic and the most *natural*).")
  tk2tip(entrylabel_CS, "Select Cosine Distance (a classic distance in multidimensional methods).")
  tk2tip(entrylabel_MM, "Select Min-Max distance (aka Ruzicka distance).")
  
  
  # next row: SAMPLING
  entry_SAMP <- tkradiobutton(f4)
  entry_RAND <- tkradiobutton(f4)
  entry_NOSAMP <- tkradiobutton(f4)
  
  tkconfigure(entry_SAMP, variable=sampling, value="normal.sampling")
  tkconfigure(entry_RAND, variable=sampling, value="random.sampling")
  tkconfigure(entry_NOSAMP, variable=sampling, value="no.sampling")
  
  entry_SAMPLESIZE <- tkentry(f4,textvariable=sample.size,width="10")
  entry_NO.OF.SAMPLES <- tkentry(f4,textvariable=number.of.samples,width="10")
  
  entrylabel_SAMP <- tklabel(f4,text="Normal sampling")
  entrylabel_RAND <- tklabel(f4,text="Random sampling")
  entrylabel_NOSAMP <- tklabel(f4,text="No sampling")
  
  entrylabel_SAMPLESIZE <- tklabel(f4, text="Sample size")
  entrylabel_NO.OF.SAMPLES <- tklabel(f4,text="Random samples")
  
  
  # Position and display sampling parameters on the grid:
  tkgrid(entrylabel_NOSAMP,entrylabel_SAMP, entrylabel_RAND)
  tkgrid(entry_NOSAMP, entry_SAMP, entry_RAND)
  tkgrid(tklabel(f4,text="    "),entrylabel_SAMPLESIZE, entrylabel_NO.OF.SAMPLES)
  tkgrid(tklabel(f4,text="    "),entry_SAMPLESIZE, entry_NO.OF.SAMPLES)
  tkgrid(tklabel(f4,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_SAMP, "Specify whether the texts in the corpus should be divided in equal-sized samples.")
  tk2tip(entrylabel_SAMPLESIZE, "Specify the size for the samples (expressed in words). \nOnly relevant when normal sampling is switched on.")
  tk2tip(entrylabel_RAND, "When the analyzed texts are significantly unequal in length, \nit is not a bad idea to prepare samples as randomly chosen *bags of words*. \nIf this option is switched on, the desired size of a sample should be indicated.")
  tk2tip(entrylabel_NO.OF.SAMPLES, "Specify the number of random samples per text. \nOnly relevant when random sampling is switched on.")
  tk2tip(entrylabel_NOSAMP, "No internal sampling will be performed: entire texts are considered as samples.")
  
  # next row: OUTPUT
  #
  cb_SCRN <- tkcheckbutton(f5)
  cb_PDF <- tkcheckbutton(f5)
  cb_JPG <- tkcheckbutton(f5)
  cb_SVG <- tkcheckbutton(f5)
  cb_PNG <- tkcheckbutton(f5)
  cb_PLOT.RESET <- tkcheckbutton(f5)
  entry_COLOR <- tkradiobutton(f5)
  entry_GRAY <- tkradiobutton(f5)
  entry_BW <- tkradiobutton(f5)
  entry_LABELS <-tkradiobutton(f5)
  entry_POINTS <-tkradiobutton(f5)
  entry_BOTH <-tkradiobutton(f5)
  entry_CLASSIC <- tkradiobutton(f5)
  entry_LOADINGS <- tkradiobutton(f5)
  entry_TECHNICAL <- tkradiobutton(f5)
  entry_SYMBOLS <- tkradiobutton(f5)
  cb_TITLE <- tkcheckbutton(f5)
  cb_HORIZ <- tkcheckbutton(f5)
  cb_TABLESAVE <- tkcheckbutton(f5)
  cb_FEATURESAVE <- tkcheckbutton(f5)
  cb_FREQSAVE <-tkcheckbutton(f5)
  cb_DUMPSAMPLES<-tkcheckbutton(f5)
  
  tkconfigure(entry_LABELS, variable=text.id.on.graphs, value="labels")
  tkconfigure(entry_POINTS, variable=text.id.on.graphs, value="points")
  tkconfigure(entry_BOTH, variable=text.id.on.graphs, value="both")
  entry_MARGINS <- tkentry(f5,textvariable=add.to.margins,width="8")
  entry_OFFSET <- tkentry(f5,textvariable=label.offset,width="8")
  entry_PLOT.HEIGHT <- tkentry(f5,textvariable=plot.custom.height,width="8")
  entry_PLOT.WIDTH <- tkentry(f5,textvariable=plot.custom.width,width="8")
  entry_PLOT.FONT <- tkentry(f5,textvariable=plot.font.size,width="8")
  entry_PLOT.LINE <- tkentry(f5,textvariable=plot.line.thickness,width="8")
  tkconfigure(cb_SCRN,variable=display.on.screen)
  tkconfigure(cb_PDF,variable=write.pdf.file)
  tkconfigure(cb_JPG,variable=write.jpg.file)
  tkconfigure(cb_SVG,variable=write.svg.file)
  tkconfigure(cb_PNG,variable=write.png.file)
  tkconfigure(entry_COLOR, variable=colors.on.graphs, value="colors")
  tkconfigure(entry_GRAY, variable=colors.on.graphs, value="greyscale")
  tkconfigure(entry_BW, variable=colors.on.graphs, value="black")
  tkconfigure(cb_PLOT.RESET,variable=plot.options.reset)
  tkconfigure(entry_CLASSIC, variable=pca.visual.flavour, value="classic")
  tkconfigure(entry_LOADINGS, variable=pca.visual.flavour, value="loadings")
  tkconfigure(entry_TECHNICAL, variable=pca.visual.flavour, value="technical")
  tkconfigure(entry_SYMBOLS, variable=pca.visual.flavour, value="symbols")
  tkconfigure(cb_TITLE,variable=titles.on.graphs)
  tkconfigure(cb_HORIZ,variable=dendrogram.layout.horizontal)
  tkconfigure(cb_TABLESAVE,variable=save.distance.tables)
  tkconfigure(cb_FEATURESAVE,variable=save.analyzed.features)
  tkconfigure(cb_FREQSAVE,variable=save.analyzed.freqs)
  tkconfigure(cb_DUMPSAMPLES,variable=dump.samples)
  
  
  #
  cblabel_SCRN <- tklabel(f5, text="     Onscreen     ")
  cblabel_PDF <- tklabel(f5,text="       PDF        ")
  cblabel_JPG <- tklabel(f5,text="       JPG        ")
  cblabel_SVG <- tklabel(f5,text="       SVG        ")
  cblabel_PNG <- tklabel(f5,text="       PNG        ")
  entrylabel_COLOR <- tklabel(f5,text="Colors")
  entrylabel_GRAY <- tklabel(f5,text="Grayscale")
  entrylabel_BW <- tklabel(f5,text="Black")
  cblabel_PLOT.RESET <- tklabel(f5,text="Set default")
  entrylabel_PLOT.HEIGHT <- tklabel(f5,text="Plot height")
  entrylabel_PLOT.WIDTH <- tklabel(f5,text="Plot width")
  entrylabel_PLOT.FONT <- tklabel(f5,text="Font size")
  entrylabel_PLOT.LINE <- tklabel(f5,text="Line width")
  entrylabel_LABELS <- tklabel(f5,text="Labels")
  entrylabel_POINTS <- tklabel(f5,text="Points")
  entrylabel_BOTH <- tklabel(f5,text="Both")
  entrylabel_MARGINS <- tklabel(f5,text="Margins")
  entrylabel_OFFSET <- tklabel(f5,text="Label offset")
  entrylabel_CLASSIC <- tklabel(f5,text="      Classic    ")
  entrylabel_LOADINGS <- tklabel(f5,text="      Loadings   ")
  entrylabel_TECHNICAL <- tklabel(f5,text="      Technical  ")
  entrylabel_SYMBOLS <- tklabel(f5,text="      Symbols    ")
  cblabel_TITLE <- tklabel(f5,text="      Titles      ")
  cblabel_HORIZ <- tklabel(f5,text="Horizontal CA tree")
  cblabel_TABLESAVE <- tklabel(f5,text="Save distance table")
  cblabel_FEATURESAVE <- tklabel(f5,text="Save features")
  cblabel_FREQSAVE <- tklabel(f5,text="Save frequencies")
  cblabel_DUMPSAMPLES <- tklabel(f5,text="Dump samples")
  
  
  #
  tkgrid(tklabel(f5,text="     GRAPHS:"), cblabel_SCRN,cblabel_PDF, cblabel_JPG,cblabel_SVG,cblabel_PNG,columnspan=5)
  tkgrid(tklabel(f5,text="            "), cb_SCRN,cb_PDF,cb_JPG,cb_SVG,cb_PNG,columnspan=5)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  tkgrid(tklabel(f5,text="  PLOT AREA:"), cblabel_PLOT.RESET,entrylabel_PLOT.HEIGHT, entrylabel_PLOT.WIDTH,entrylabel_PLOT.FONT,entrylabel_PLOT.LINE,columnspan=5)
  tkgrid(tklabel(f5,text="            "), cb_PLOT.RESET,entry_PLOT.HEIGHT,entry_PLOT.WIDTH,entry_PLOT.FONT,entry_PLOT.LINE,columnspan=5)
  tkgrid(tklabel(f5,text="            "), tklabel(f5,text="    "),entrylabel_COLOR,entrylabel_GRAY,entrylabel_BW,cblabel_TITLE,columnspan=5)
  tkgrid(tklabel(f5,text="            "), tklabel(f5,text="    "),entry_COLOR,entry_GRAY,entry_BW,cb_TITLE,columnspan=5)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  tkgrid(tklabel(f5,text="    PCA/MDS:"), entrylabel_LABELS, entrylabel_POINTS, entrylabel_BOTH, entrylabel_MARGINS,entrylabel_OFFSET, columnspan=5)
  tkgrid(tklabel(f5,text="            "), entry_LABELS, entry_POINTS, entry_BOTH, entry_MARGINS,entry_OFFSET, columnspan=5)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  tkgrid(tklabel(f5,text="PCA FLAVOUR:"), entrylabel_CLASSIC, entrylabel_LOADINGS, entrylabel_TECHNICAL, entrylabel_SYMBOLS, columnspan=5)
  tkgrid(tklabel(f5,text="            "), entry_CLASSIC, entry_LOADINGS, entry_TECHNICAL, entry_SYMBOLS, columnspan=5)
  tkgrid(tklabel(f5,text="    VARIOUS:"), cblabel_HORIZ,cblabel_TABLESAVE,cblabel_FEATURESAVE,cblabel_FREQSAVE,cblabel_DUMPSAMPLES, columnspan=5)
  tkgrid(tklabel(f5,text="            "), cb_HORIZ,cb_TABLESAVE,cb_FEATURESAVE,cb_FREQSAVE,cb_DUMPSAMPLES, columnspan=5)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(cblabel_SCRN, "Select to have your diagram(s) displayed on R's standard graphics device.")
  tk2tip(cblabel_PDF, "Select to save your diagram(s) as (a) PDF file(s).")
  tk2tip(cblabel_JPG, "Select to save your diagram(s) as (a) JPG file(s).")
  tk2tip(cblabel_SVG, "Select to save your diagram(s) as (a) SVG file(s).")
  tk2tip(cblabel_PNG, "Select to save your diagram(s) as (a) PNG file(s). \nProbably the best option for quality.")
  tk2tip(cblabel_PLOT.RESET, "Restore graphic parameters to safe default values \n(7x7 inches, 10 points font size, normal line width).")
  tk2tip(entrylabel_PLOT.HEIGHT, "Set custom plot height (in inches).")
  tk2tip(entrylabel_PLOT.WIDTH, "Set custom plot width (in inches).")
  tk2tip(entrylabel_PLOT.FONT, "Set custom font size (in points).")
  tk2tip(entrylabel_PLOT.LINE, "Set custom line width \n(in R units, 1 is default).")
  tk2tip(entrylabel_COLOR, "Select to have automatic color coding for tip labels by author.")
  tk2tip(entrylabel_GRAY, "Select to have automatic color coding (in greyscale) for tip labels by author.")
  tk2tip(entrylabel_BW, "Select to have a black & white graph.")
  tk2tip(cblabel_TITLE, "Select to have automatic titles (folder name, analysis type, \nMFW settings, analysis type etc.) on your graph(s).")
  tk2tip(entrylabel_LABELS, "Use only labels on MDS/PCA plots.")
  tk2tip(entrylabel_POINTS, "Use only points on MDS/PCA plots.")
  tk2tip(entrylabel_BOTH, "Use both labels and points on MDS/PCA plots.")
  tk2tip(entrylabel_MARGINS, "Set custom margin size \n(in percentage of plot area).")
  tk2tip(entrylabel_OFFSET, "Set custom offset between label and point \n(in percentage of plot area.")
  tk2tip(entrylabel_CLASSIC, "Original PCA visualization using (colored) sample names") 
  tk2tip(entrylabel_LOADINGS, "Display PCA feature (word etc.) loadings.") 
  tk2tip(entrylabel_TECHNICAL, "Technical greyscale PCA visualization, showing feature loadings as well as a PC barplot.\nPotentially useful for greyscale printing in traditional publications.")
  tk2tip(entrylabel_SYMBOLS, "Select to display the samples in your PCA with a group symbol (instead of their entire name).\n Potentially useful when dealing with lots of samples.")
  tk2tip(cblabel_HORIZ, "Select to have your Cluster Analysis graph oriented horizontally. \nProbably the better option for clarity.")
  tk2tip(cblabel_TABLESAVE, "Save final distance table(s) in separate text file(s).")
  tk2tip(cblabel_FEATURESAVE, "Save final feature (word, n-gram) list(s), e.g. the words actually used in the analysis.")
  tk2tip(cblabel_FREQSAVE, "Save frequency table(s) in separate text file(s).")
  tk2tip(cblabel_DUMPSAMPLES, "Save a dump of all samples in the directory 'Dumps' for post-analysis inspection.")
  
  tkgrid(tklabel(tt,text="    ")) # blank line (i.e., bottom margin)
  
  
  #ROW 6 NORMALIZATION
  entry_norm1 <- tkcheckbutton(f6) #1
  entry_norm2 <- tkcheckbutton(f6) #1
  entry_norm3 <- tkcheckbutton(f6) #1
  entry_norm4 <- tkcheckbutton(f6) #1
  entry_norm5 <- tkcheckbutton(f6) #1
  entry_norm6 <- tkcheckbutton(f6) #1
  entry_norm7 <- tkcheckbutton(f6) #1
  entry_norm8 <- tkcheckbutton(f6) #1
  #entry_norm9 <- tkcheckbutton(f6) #1
  entry_norm10 <- tkcheckbutton(f6) #1
  entry_norm11 <- tkcheckbutton(f6) #1
  entry_norm12 <- tkcheckbutton(f6) #1
  entry_norm13 <- tkcheckbutton(f6) #1
  entry_norm14 <- tkcheckbutton(f6) #1
  entry_norm15 <- tkcheckbutton(f6) #1
  entry_norm16 <- tkcheckbutton(f6) #1
  entry_norm17 <- tkcheckbutton(f6) #1
  entry_norm18 <- tkcheckbutton(f6) #1
  entry_norm19 <- tkcheckbutton(f6) #1
  
  tkconfigure(entry_norm1, variable=trnom.disambidia)
  tkconfigure(entry_norm2, variable=trnom.repbehau)
  tkconfigure(entry_norm3, variable=trnom.expael)
  tkconfigure(entry_norm4, variable=trnom.translitgr)
  tkconfigure(entry_norm5, variable=trnom.iota)
  tkconfigure(entry_norm6, variable=trnom.alldel)
  tkconfigure(entry_norm7, variable=trnom.numbering)
  tkconfigure(entry_norm8, variable=trnom.ligdel)
  #tkconfigure(entry_norm9, variable=trnom.diadel)
  tkconfigure(entry_norm10, variable=trnom.interdel)
  tkconfigure(entry_norm11, variable=trnom.unkown)
  tkconfigure(entry_norm12, variable=trnom.umbr)
  tkconfigure(entry_norm13, variable=trnom.mak)
  tkconfigure(entry_norm14, variable=trnom.sigma)
  tkconfigure(entry_norm15, variable=trnom.klam)
  tkconfigure(entry_norm16, variable=trnom.uv)
  tkconfigure(entry_norm17, variable=trnom.ji)
  tkconfigure(entry_norm18, variable=trnom.hyph)
  tkconfigure(entry_norm19, variable=trnom.alphapriv)
  
  entrylabel_norm1 <- tklabel(f6,text="Disam. diacrit.")
  entrylabel_norm2 <- tklabel(f6,text="Replace diacrit.")
  entrylabel_norm3 <- tklabel(f6,text="Exp. elisions")
  entrylabel_norm4 <- tklabel(f6,text="Translit. Greek")
  entrylabel_norm5 <- tklabel(f6,text="Iota sub / ad")
  entrylabel_norm6 <- tklabel(f6,text="All del")
  entrylabel_norm7 <- tklabel(f6,text="Delete numbering")
  entrylabel_norm8 <- tklabel(f6,text="Delete ligatures")
  
  #entrylabel_norm9 <- tklabel(f6,text="Delet diakrit.")
  entrylabel_norm10 <- tklabel(f6,text="Delete punctuation")
  entrylabel_norm11 <- tklabel(f6,text="Delete unkown signs")
  entrylabel_norm12 <- tklabel(f6,text="Line break to space")
  entrylabel_norm13 <- tklabel(f6,text="Delete markup")
  entrylabel_norm14 <- tklabel(f6,text="Eq. sigma")
  entrylabel_norm15 <- tklabel(f6,text="Delete brackets")
  entrylabel_norm16 <- tklabel(f6,text="UV (Latin)")
  entrylabel_norm17 <- tklabel(f6,text="IJ (Latin)")
  entrylabel_norm18 <- tklabel(f6,text="Handle hyphenation")
  entrylabel_norm19 <- tklabel(f6,text="Alpha privativum")
  
  
  
  tkgrid( entry_norm1, entry_norm2, entry_norm3,entry_norm4,   entry_norm5 )
  tkgrid( entrylabel_norm1,entrylabel_norm2,entrylabel_norm3,entrylabel_norm4,entrylabel_norm5)
  tkgrid( entry_norm6, entry_norm7,entry_norm8,   entry_norm10 )
  tkgrid( entrylabel_norm6,entrylabel_norm7,entrylabel_norm8,entrylabel_norm10)
  tkgrid( entry_norm11,entry_norm12,entry_norm13,entry_norm14,entry_norm15 )
  tkgrid( entrylabel_norm11,entrylabel_norm12,entrylabel_norm13,entrylabel_norm14,entrylabel_norm15)
  tkgrid( entry_norm16,entry_norm17,entry_norm18,entry_norm19 )
  tkgrid( entrylabel_norm16,entrylabel_norm17,entrylabel_norm18,entrylabel_norm19)
  
  # wait until we have input
  tkwait.window(tt)
  
  # set the doneVal = 1 when the OK button was clicke
  # closing the window using any other button (or killing it) stops the script
  doneVal = as.integer(tclvalue(done))
  tkdestroy(tt)
  
  
  
  variables$analyzed.features = as.character(tclvalue(analyzed.features))
  variables$analyzed.padding = as.logical(as.numeric(tclvalue(analyzed.padding)))
   
  variables$ngram.size = as.numeric(tclvalue(ngram.size))
  variables$preserve.case = as.logical(as.numeric(tclvalue(preserve.case)))
  #print("var in gui")
  #print(variables$preserve.case)
  #print(variables$analyzed.padding)
  variables$corpus.format = as.character(tclvalue(corpus.format))
  variables$mfw.min = as.numeric(tclvalue(mfw.min))
  variables$mfw.max = as.numeric(tclvalue(mfw.max))
  variables$mfw.incr = as.numeric(tclvalue(mfw.incr))
  variables$start.at = as.numeric(tclvalue(start.at))
  variables$culling.min = as.numeric(tclvalue(culling.min))
  variables$culling.max = as.numeric(tclvalue(culling.max))
  variables$culling.incr = as.numeric(tclvalue(culling.incr))
  variables$use.existing.freq.tables = as.logical(as.numeric(tclvalue(use.existing.freq.tables)))
  variables$use.existing.wordlist = as.logical(as.numeric(tclvalue(use.existing.wordlist)))
  variables$interactive.files = as.logical(as.numeric(tclvalue(interactive.files)))
  variables$use.custom.list.of.files = as.logical(as.numeric(tclvalue(use.custom.list.of.files)))
  variables$analysis.type = as.character(tclvalue(analysis.type))
  variables$delete.pronouns = as.logical(as.numeric(tclvalue(delete.pronouns)))
  variables$display.on.screen = as.logical(as.numeric(tclvalue(display.on.screen)))
  variables$write.pdf.file = as.logical(as.numeric(tclvalue(write.pdf.file)))
  variables$write.jpg.file = as.logical(as.numeric(tclvalue(write.jpg.file)))
  variables$write.svg.file = as.logical(as.numeric(tclvalue(write.svg.file)))
  variables$write.png.file = as.logical(as.numeric(tclvalue(write.png.file)))
  variables$dump.samples = as.logical(as.numeric(tclvalue(dump.samples)))
  variables$colors.on.graphs = as.character(tclvalue(colors.on.graphs))
  variables$pca.visual.flavour = as.character(tclvalue(pca.visual.flavour))
  variables$titles.on.graphs = as.logical(as.numeric(tclvalue(titles.on.graphs)))
  variables$dendrogram.layout.horizontal = as.logical(as.numeric(tclvalue(dendrogram.layout.horizontal)))
  variables$save.distance.tables = as.logical(as.numeric(tclvalue(save.distance.tables)))
  variables$save.analyzed.features = as.logical(as.numeric(tclvalue(save.analyzed.features)))
  variables$save.analyzed.freqs = as.logical(as.numeric(tclvalue(save.analyzed.freqs)))
  variables$sampling = as.character(tclvalue(sampling))
  variables$sample.size = as.numeric(tclvalue(sample.size))
  variables$number.of.samples = as.numeric(tclvalue(number.of.samples))
  variables$mfw.list.cutoff = as.numeric(tclvalue(mfw.list.cutoff))
  variables$distance.measure = as.character(tclvalue(distance.measure))
  variables$corpus.lang = as.character(tclvalue(corpus.lang))
  variables$consensus.strength = as.numeric(tclvalue(consensus.strength))
  variables$plot.options.reset = as.logical(as.numeric(tclvalue(plot.options.reset)))
  variables$plot.custom.height = as.numeric(tclvalue(plot.custom.height))
  variables$plot.custom.width = as.numeric(tclvalue(plot.custom.width))
  variables$plot.font.size = as.numeric(tclvalue(plot.font.size))
  variables$plot.line.thickness = as.numeric(tclvalue(plot.line.thickness))
  variables$text.id.on.graphs = as.character(tclvalue(text.id.on.graphs))
  variables$add.to.margins = as.numeric(tclvalue(add.to.margins))
  variables$label.offset = as.numeric(tclvalue(label.offset))
  variables$encoding = as.logical(as.numeric(tclvalue(encoding)))
  
  
  
  variables["trnom.disambidia"] <- as.logical(as.numeric(tclvalue(trnom.disambidia)))
  variables["trnom.repbehau"] <- as.logical(as.numeric(tclvalue(trnom.repbehau)))
  variables["trnom.expael"] <- as.logical(as.numeric(tclvalue(trnom.expael)))
  variables["trnom.translitgr"] <- as.logical(as.numeric(tclvalue(trnom.translitgr)))
  variables["trnom.iota"] <- as.logical(as.numeric(tclvalue(trnom.iota)))
  variables["trnom.alldel"] <- as.logical(as.numeric(tclvalue(trnom.alldel)))
  variables["trnom.numbering"] <- as.logical(as.numeric(tclvalue(trnom.numbering)))
  variables["trnom.ligdel"] <- as.logical(as.numeric(tclvalue(trnom.ligdel)))
  #variables["trnom.diadel"] <- as.logical(as.numeric(tclvalue(trnom.diadel)))
  variables["trnom.interdel"] <- as.logical(as.numeric(tclvalue(trnom.interdel)))
  variables["trnom.unkown"] <- as.logical(as.numeric(tclvalue(trnom.unkown)))
  variables["trnom.umbr"] <- as.logical(as.numeric(tclvalue(trnom.umbr)))
  variables["trnom.mak"] <- as.logical(as.numeric(tclvalue(trnom.mak)))
  variables["trnom.sigma"] <- as.logical(as.numeric(tclvalue(trnom.sigma)))
  variables["trnom.klam"] <- as.logical(as.numeric(tclvalue(trnom.klam)))
  variables["trnom.uv"] <- as.logical(as.numeric(tclvalue(trnom.uv)))
  variables["trnom.ji"] <- as.logical(as.numeric(tclvalue(trnom.ji)))
  variables["trnom.hyph"] <- as.logical(as.numeric(tclvalue(trnom.hyph)))
  variables["trnom.alphapriv"] <- as.logical(as.numeric(tclvalue(trnom.alphapriv)))
  
  #print(variables)
  
  .Tcl("font delete myDefaultFont")
  
  
  
  
  # switching back from logical values into strings
  if(variables$encoding == FALSE) {
    variables$encoding = "UTF-8"
  } else {
    variables$encoding = "native.enc"
  }
  
  
  
  if (doneVal != 1) {
    variables = NULL
  }
  
  
  return(variables)
}
