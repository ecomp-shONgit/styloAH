
#################################################################
# A high-level function that ties a number of other functions responsible
# for uploading texts, deleting markup, sampling, splitting into n-grams, etc.
# It is build on top of a number of functions and thus it requires a large
# number of arguments. See:
#
# load.corpus(corpus.dir="",files)
# delete.markup(input.text,markup.type="plain")
# txt.to.words.ext(input.text,corpus.lang="English")
# make.samples(tokenized.input.data,sample.size=10000,sampling="no.sampling",
#   sampling.with.replacement=FALSE)
# txt.to.features(tokenized.text,features="w",ngram.size=1)
#
#################################################################

load.corpus.and.parse = function(files = "all",
         corpus.dir = "",
         markup.type = "plain",
         corpus.lang = "English",
         splitting.rule = NULL,
         sample.size = 10000,
         sampling = "no.sampling",
         sample.overlap = 0,
         number.of.samples = 1,
         sampling.with.replacement = FALSE,
         features = "w",
         ngram.size = 1,
         preserve.case = FALSE,
         padding = FALSE,
         encoding = "UTF-8",
         trnom.disambidia = FALSE,
	trnom.repbehau = FALSE,
	trnom.expael = FALSE,
	trnom.translitgr = FALSE,
	trnom.iota = FALSE,
	trnom.alldel = FALSE,
	trnom.numbering = FALSE,
	trnom.ligdel = FALSE,
	trnom.unterpunkt = FALSE,
	trnom.interdel = FALSE,
	trnom.unkown = FALSE,
	trnom.umbr = FALSE,
	trnom.mak = FALSE,
	trnom.sigma = FALSE,
	trnom.klam = FALSE,
	trnom.uv = FALSE,
	trnom.ji = FALSE,
	trnom.hyph = FALSE,
	trnom.alphapriv = FALSE,
    trnom.gravistoakut = FALSE) {


  # first, checking which files were requested; usually, the user is 
  # expected to specify a vector with samples' names
#  if(files[1] == "all") {
#  	  files = list.files(all.files = FALSE)
#  }

loaded.corpus = load.corpus(files = files,
                              corpus.dir = corpus.dir,
                              encoding = encoding)
#message(length(loaded.corpus))
  # dropping file extensions from sample names
  names(loaded.corpus) = gsub("(\\.txt$)||(\\.xml$)||(\\.html$)||(\\.htm$)","",
                         names(loaded.corpus) )
  message("Text normalization...")
  # deleting xml/html markup by applying the function "delete.markup"
  loaded.corpus = lapply(loaded.corpus, delete.markup, markup.type = markup.type)
  #
  numCores <- detectCores( ) # change this to numCores = numCores - 1 maybe
  #message(numCores)
  loaded.corpus = mclapply( loaded.corpus,
             FUN=tn.nor, 
            trnom.disambidia = trnom.disambidia,
			trnom.repbehau = trnom.repbehau,
			trnom.expael = trnom.expael,
			trnom.translitgr = trnom.translitgr,
			trnom.iota = trnom.iota,
			trnom.alldel = trnom.alldel,
			trnom.numbering = trnom.numbering,
			trnom.ligdel = trnom.ligdel,
			trnom.unterpunkt = trnom.unterpunkt,
			trnom.interdel = trnom.interdel,
			trnom.unkown = trnom.unkown,
			trnom.umbr = trnom.umbr,
			trnom.mak = trnom.mak,
			trnom.sigma = trnom.sigma,
			trnom.klam = trnom.klam,
			trnom.uv = trnom.uv,
			trnom.ji = trnom.ji,
			trnom.hyph = trnom.hyph,
			trnom.alphapriv = trnom.alphapriv,
            trnom.gravistoakut = trnom.gravistoakut,
            mc.cores = numCores)
    
   #message(loaded.corpus )          
  # normalization stylo AH edition
 # loaded.corpus = lapply(loaded.corpus, tn.nor, 
  #          trnom.disambidia = trnom.disambidia,
	#		trnom.repbehau = trnom.repbehau,
	#		trnom.expael = trnom.expael,
	#		trnom.translitgr = trnom.translitgr,
	#		trnom.iota = trnom.iota,
	#		trnom.alldel = trnom.alldel,
	#		trnom.numbering = trnom.numbering,
	#		trnom.ligdel = trnom.ligdel,
	#		trnom.unterpunkt = trnom.unterpunkt,
	#		trnom.interdel = trnom.interdel,
	#		trnom.unkown = trnom.unkown,
	#		trnom.umbr = trnom.umbr,
	#		trnom.mak = trnom.mak,
	#		trnom.sigma = trnom.sigma,
	#		trnom.klam = trnom.klam,
	#		trnom.uv = trnom.uv,
	#		trnom.ji = trnom.ji,
	#		trnom.hyph = trnom.hyph,
	#		trnom.alphapriv = trnom.alphapriv,
     #      trnom.gravistoakut = trnom.gravistoakut)
  
  # deleting punctuation, splitting into words
  message("Slicing input text into words...\n")
  loaded.corpus = mclapply(loaded.corpus, FUN=txt.to.words.ext,
            corpus.lang = corpus.lang,
            splitting.rule = splitting.rule,
            preserve.case = preserve.case,
            mc.cores = numCores)
  #loaded.corpus = lapply(loaded.corpus, txt.to.words.ext,
  #                                      corpus.lang = corpus.lang,
  #                                      splitting.rule = splitting.rule,
  #                                      preserve.case = preserve.case)
  
  # normal sampling (if applicable); random sampling will be run later
  if(sampling == "normal.sampling") {
    message("Do sampling ...\n")
    loaded.corpus = make.samples(loaded.corpus,
                                 sample.size,
                                 sampling,
                                 sample.overlap)
  }
  # split into chars (if applicable), agglutinate into n-grams
  # [it takes a good while when char n-grams are chosen]
  message("\nTurning words into features, e.g. char n-grams (if applicable)...")
  #loaded.corpus = lapply(loaded.corpus, txt.to.features,
  #                       features = features, ngram.size = ngram.size, padding = padding)
  loaded.corpus = mclapply(loaded.corpus, txt.to.features,
                         features = features, ngram.size = ngram.size, padding = padding,
            mc.cores = numCores)
  # optionally, excerpt randomly a number of features from original data
  if(sampling == "random.sampling") {
    loaded.corpus = make.samples(loaded.corpus,
                                 sample.size,
                                 sampling,
                                 sample.overlap = 0,
                                 number.of.samples,
                                 sampling.with.replacement)
  }

  # assigning a class
  class(loaded.corpus) = "stylo.corpus"
  # adding some information about the current function call
  # to the final list of results
  attr(loaded.corpus, "call") = match.call()

# returning the value
return(loaded.corpus)
}

