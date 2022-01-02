
# #################################################
# Function that carries out the necessary modifications
# for feature selection: convert an input text into
# the type of sequence needed (n-grams etc.) and
# returns the new list of items
# Argument: a vector of words (or chars)
# #################################################

txt.to.features = function(tokenized.text, features = "w", ngram.size = 1, padding = FALSE){
  
    # since the function can be applied to lists and vectors,
    # we need to define an internal function that will be applied afterwards
    wrapper = function(tokenized.text, features = "w", ngram.size = 1, padding = FALSE ){    
        
        #print(features) 
        #print(ngram.size)
        #print(padding)
        
        # Splitting the text into chars (if "features" was set to "c")
        if( features == "w" ){
            # otherwise, leaving the original text unchanged
            sample = tokenized.text
            #print(sample)
            if( ngram.size > 1 ) {
                sample = make.ngrams(sample, ngram.size = ngram.size) 
            }
        } else {
            sample = paste(tokenized.text, collapse=" ")
            if( features == "c" ){ #original stylo version
                #print(sample)
                sample = unlist(strsplit(sample,""))
                # replacing  spaces with underscore
                # it is a very proc time consuming task; thus, let's drop it
                #    sample = gsub(" ","_",sample)
                if( ngram.size > 1 ) {
                    sample = make.ngrams(sample, ngram.size = ngram.size)
                    #    # getting rid of additional spaces added around chars
                    #    # it is a very proc time consuming task; thus, let's drop it
                    #    if(features == "c") {
                    #      sample = gsub(" ","",sample)
                    #    }
                    
                }
                #print(sample)
            } else if( features == "wlc" ){
                sample = ngramWordsFlat( tokenized.text, ngram.size, padding )
                #print(sample)
            } else if( features == "sepdia" ){ ### stylo AH implementation of different things - do not knwo how samples should look like
                #separate diacriticas and letters                
                print("Not implemented, sepdia")
                sample = tokenized.text
            } else if( features == "woc" ){ 
                #without consonants
                sample = ohneKon( tokenized.text )
                #print( sample )
            } else if( features == "wov" ){ 
                #without vowels
                sample = ohnVoka( tokenized.text )
                #print(sample)
            } else if( features == "smw" ){ 
                #just small words
                sample = jukl( tokenized.text )
                #print(sample)
            } else if( features == "bw" ){ 
                #just big words
                sample = jugr( tokenized.text )
                #print(sample)
            } else if( features == "syl" ){ 
                #pseudo syllables
                sample = silbenWithprep( tokenized.text )
                #print(sample)
            } else if( features == "hbc1" ){ 
                #head body coda
                sample = toKKC( tokenized.text )
                print(sample)
            } else if( features == "hbc2" ){ 
                #head body coda 2 all partitions
                sample = toKKCnSufixWordsFlat( tokenized.text )
                #print(sample)
            } else if( features == "smwpa" ){ 
                
                #group small words and gap encodings after a minimized heuristics of the groupe
                sample = reserialpseudosyntagma( tokenized.text )
                #print(sample)
            } else {
                print("ERROR stylo AH split the text - called features")
            }

            
        }
        # 2. making n-grams (if an appropriate option has been chosen):
        
        #
        return(sample)
  }



        # the proper procedure applies, depending on what kind of data 
        # is analyzed
        
        # test if the dataset has a form of a single string (a vector)
        if(is.list(tokenized.text) == FALSE) {
                # apply an appropriate replacement function
                sample = wrapper(tokenized.text, 
                                           features = features, 
                                           ngram.size = ngram.size,
                                           padding = padding)
                # if the dataset has already a form of list
        } else {
                # applying an appropriate function to a corpus:
                sample = lapply(tokenized.text, wrapper, 
                                features = features, 
                                ngram.size = ngram.size,
                                padding = padding )
                class(sample) = "stylo.corpus"
        }
        



return(sample)
}
