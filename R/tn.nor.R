
# #################################################
# Function for adjusting different input formats:
# get plain text and do some further normalization
# see github ...
# #################################################


tn.nor = function(
        input.text, 
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
		trnom.hyph= FALSE,
		trnom.alphapriv = FALSE,
        trnom.gravistoakut = FALSE ) {
         	  
        # since the function can be applied to lists and vectors,
        # we need to define an internal function that will be applied afterwards
        wrapper = function(input.text = input.text, 
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
            trnom.gravistoakut = trnom.gravistoakut) {
			#message(trnom.alldel)
			#message("in tnnorr")
			
			preprocessed.text = paste(input.text)
			
			preprocessed.text = normatexttoanaenc(preprocessed.text)
			
			
			# replace unterpunkt
  			if( trnom.unterpunkt == TRUE ){
		        #start_time = Sys.time()
		        preprocessed.text = delwithnormUnterpunkt( preprocessed.text )
		        #e_time = Sys.time()
		        #message("After unterpunkte ", e_time-start_time)
  			}
  			
    		#preprocessed.text = normatext( paste(input.text), "NFKD" )  
    		if( trnom.disambidia == TRUE ){
    		    #start_time = Sys.time()
    			preprocessed.text = disambiguDIAkritika( preprocessed.text )
    			#e_time = Sys.time()
    			#message("after Disambigu Diak ", e_time-start_time)
    		}
            if( trnom.gravistoakut == TRUE ){
    		    #start_time = Sys.time()
    			preprocessed.text = gravisakut( preprocessed.text )
    			#e_time = Sys.time()
    			#message("after Disambigu Diak ", e_time-start_time)
    		}
        		
  			#Alpha priv
  			if( trnom.alphapriv == TRUE ){
  			    #start_time = Sys.time()
        	    preprocessed.text = AlphaPrivativumCopulativumText( preprocessed.text )
        	    #e_time = Sys.time()
        	    #message("After AlphaPriv ", e_time-start_time)
            }
        		# given a string, elusions will be expanded
  			if( trnom.expael == TRUE ){
  			    #start_time = Sys.time()
    			preprocessed.text = ExpandelisionText( preprocessed.text )
    			#e_time = Sys.time()
    			#message("After Elision ", e_time-start_time)
    		}
        		
        		#INCLUDE INSCHRIFTEN KLAMMERSYSTEM AND REMOVE THE KLAMMERUNG AND OTEHR SIGNS FROM THE EDITOR / EDITION / TEXTDEFORMATION DESCRIPTION
        		# see WORKAROUND **
        		
  			#input string, removes hyphenation
  			if( trnom.hyph == TRUE ){
  			    #start_time = Sys.time()
		        #message(preprocessed.text)
		        preprocessed.text = delklammern( preprocessed.text ) # THIS IS A WORKAROUND **
    			preprocessed.text = TrennstricherausText( preprocessed.text )
    			#e_time = Sys.time()
    			#message("After Hyphenation ", e_time-start_time)
    		}
                        
  			#deletes UV, IJ, klammern, sigma, grkl, umbrüche, 
  			#ligaturen, interpunktion, edition numbering, unknown signs, diakritika
  			if( trnom.alldel == TRUE ){
  			    #start_time = Sys.time()
  				#cat(delall( preprocessed.text ))
  				newone = delall( preprocessed.text )
  				#print(newone)
  				preprocessed.text = newone		
  				#e_time = Sys.time()
  				#message("After Delall ", e_time-start_time)
  			} else {
  			  
  			  
			  # replaces diakritika
			  if( trnom.repbehau == TRUE ){
			     #start_time = Sys.time()
  				 preprocessed.text = deldiak( preprocessed.text )
  				 #e_time = Sys.time()
  				 #message("After deldiak ", e_time-start_time)
  			  }
  			  
			  # takes greek utf8 string and repleces jota subscriptum with jota ad scriptum
			  if( trnom.iota == TRUE ){
			    #start_time = Sys.time()
  			    preprocessed.text = iotasubiotoad( preprocessed.text )
  			    #e_time = Sys.time()
  			    #message("After Iotasub ", e_time-start_time)
  			  }
			  
			  # takes string return string without the edition numbering i.e. [2]
			  if( trnom.numbering == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delnumbering( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After umbr ", e_time-start_time)
  			  }
  			  
			  # takes a string return string with ligatures turned to single letters
			  if( trnom.ligdel == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delligaturen( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After ligatures ", e_time-start_time)
  			  }
  			  
			  
  			  
			  #takes string and returns the string without
			  if( trnom.interdel == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delinterp( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After interp ", e_time-start_time)
  			  }
  			  
			  # delete some to the programmer unknown signs
			  if( trnom.unkown == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delunknown( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After unknown")
  			  }
  			  
			  # input string and get it back with linebreaks removed
			  if( trnom.umbr == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delumbrbine( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After umbrine ", e_time-start_time)
  			  }
  			  
			  #input a string and get it pack with markup removed
			  if( trnom.mak == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delmakup( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After delmarkup ", e_time-start_time)
  			  }
  			  
			  # equalize tailing sigma
			  if( trnom.sigma == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = sigmaistgleich( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After sigma ", e_time-start_time)
  			  }
  			  
			  # input stringa nd get it back with no brackets
			  if( trnom.klam == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delklammern( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After Klammers ", e_time-start_time)
  			  }
  			  
			  # repaces all u with v
			  #trnom. <- tclVar(trnom.uv)
			  if( trnom.uv == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = deluv( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After UV ", e_time-start_time)
  			  }
			  # replace all j with i
			  #trnom. <- tclVar(trnom.ji)
			  if( trnom.ji == TRUE ){
			    #start_time = Sys.time()
  				preprocessed.text = delji( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After IJ ", e_time-start_time)
  			  }
  			}
  			
  			
  			# takes greek utf8 string and returns transliterated latin utf8 string
        	if( trnom.translitgr == TRUE ){
        		#start_time = Sys.time()    
  				preprocessed.text = TraslitAncientGreekLatin( preprocessed.text )
  				#e_time = Sys.time()
  				#message("After Translit ", e_time-start_time)
  			}
                	#start_time = Sys.time()
                	# del arabic numerals
                	preprocessed.text =  delaraNumerals(preprocessed.text )  
                	# ‘ | –⏑–⏑ 
                    preprocessed.text =  signsleft( preprocessed.text )  
                    #UNterpunkt
                	#preprocessed.text =  delUnterpunkt( preprocessed.text )
                	#e_time = Sys.time()  
                #message("After some more ", e_time-start_time)
                	#
                	
			#cat(preprocessed.text)
			#checkthis <- gsub(" ", "", preprocessed.text)
			#if(nzchar(checkthis) == FALSE){
			#        print(input.text)
			#        
			#        message("ERROR in tn.nor.R no string left")
			#        
			#}
                	return(preprocessed.text)
        }
        
        preprocessed.text = wrapper(
        input.text, 
        trnom.disambidia,
		trnom.repbehau, 
        trnom.expael,
		trnom.translitgr,
		trnom.iota,
		trnom.alldel,
		trnom.numbering,
		trnom.ligdel,
		trnom.unterpunkt,
		trnom.interdel,
		trnom.unkown,
		trnom.umbr,
		trnom.mak,
		trnom.sigma,
		trnom.klam,
        trnom.uv,
        trnom.ji,
        trnom.hyph, 
        trnom.alphapriv,
        trnom.gravistoakut)
        #demUsage( )
        #message("IN TN.NOR")
        #cat(preprocessed.text)
        #message( sghja ) 
        return(preprocessed.text)
}
