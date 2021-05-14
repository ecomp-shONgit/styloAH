
# #################################################
# Function for adjusting different input formats:
# get plain text and do some further normalization
# see github ...
# #################################################


tn.nor = function(input.text, 
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
		trnom.alphapriv = FALSE) {
         	  
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
			trnom.alphapriv = trnom.alphapriv) {
			#print(trnom.alldel)
			#print("in tnnorr")
			
			preprocessed.text = paste(input.text)
			
			# replace unterpunkt
  			if( trnom.unterpunkt == TRUE ){
  			        preprocessed.text = delwithnormUnterpunkt( preprocessed.text )
  			}
  			
        		#preprocessed.text = normatext( paste(input.text), "NFKD" )  
        		if( trnom.disambidia == TRUE ){
        			preprocessed.text = disambiguDIAkritika( preprocessed.text )
        		}
        		
  			#Alpha priv
  			if( trnom.alphapriv == TRUE ){
        			preprocessed.text = AlphaPrivativumCopulativumText( preprocessed.text )
        		}
        		# given a string, elusions will be expanded
  			if( trnom.expael == TRUE ){
        			preprocessed.text = ExpandelisionText( preprocessed.text )
        		}
        		
        		#INCLUDE INSCHRIFTEN KLAMMERSYSTEM AND REMOVE THE KLAMMERUNG AND OTEHR SIGNS FROM THE EDITOR / EDITION / TEXTDEFORMATION DESCRIPTION
        		# see WORKAROUND **
        		
  			#input string, removes hyphenation
  			if( trnom.hyph == TRUE ){
  			        #print(preprocessed.text)
  			        preprocessed.text = delklammern( preprocessed.text ) # THIS A WORKAROUND **
        			preprocessed.text = TrennstricherausText( preprocessed.text )
        		}
                        
  			#deletes UV, IJ, klammern, sigma, grkl, umbrüche, 
  			#ligaturen, interpunktion, edition numbering, unknown signs, diakritika
  			if( trnom.alldel == TRUE ){
  				#cat(delall( preprocessed.text ))
  				newone = delall( preprocessed.text )
  				#cat(newone)
  				preprocessed.text = newone		
  			} else {
  			  
  			  
			  # replaces diakritika
			  if( trnom.repbehau == TRUE ){
  				preprocessed.text = deldiak( preprocessed.text )
  			  }
  			  
			  # takes greek utf8 string and repleces jota subscriptum with jota ad scriptum
			  if( trnom.iota == TRUE ){
  				preprocessed.text = iotasubiotoad( preprocessed.text )
  			  }
			  
			  # takes string return string without the edition numbering i.e. [2]
			  if( trnom.numbering == TRUE ){
  				preprocessed.text = delnumbering( preprocessed.text )
  			  }
  			  
			  # takes a string return string with ligatures turned to single letters
			  if( trnom.ligdel == TRUE ){
  				preprocessed.text = delligaturen( preprocessed.text )
  			  }
  			  
			  
  			  
			  #takes string and returns the string without
			  if( trnom.interdel == TRUE ){
  				preprocessed.text = delinterp( preprocessed.text )
  			  }
  			  
			  # delete some to the programmer unknown signs
			  if( trnom.unkown == TRUE ){
  				preprocessed.text = delunknown( preprocessed.text )
  			  }
  			  
			  # input string and get it back with linebreaks removed
			  if( trnom.umbr == TRUE ){
  				preprocessed.text = delumbrbine( preprocessed.text )
  			  }
  			  
			  #input a string and get it pack with markup removed
			  if( trnom.mak == TRUE ){
  				preprocessed.text = delmakup( preprocessed.text )
  			  }
  			  
			  # equalize tailing sigma
			  if( trnom.sigma == TRUE ){
  				preprocessed.text = sigmaistgleich( preprocessed.text )
  			  }
  			  
			  # input stringa nd get it back with no brackets
			  if( trnom.klam == TRUE ){
  				preprocessed.text = delklammern( preprocessed.text )
  			  }
  			  
			  # repaces all u with v
			  trnom. <- tclVar(trnom.uv)
			  if( trnom.uv == TRUE ){
  				preprocessed.text = deluv( preprocessed.text )
  			  }
			  # replace all j with i
			  trnom. <- tclVar(trnom.ji)
			  if( trnom.ji == TRUE ){
  				preprocessed.text = delji( preprocessed.text )
  			  }
  			}
  			
  			
  			# takes greek utf8 string and returns transliterated latin utf8 string
        		if( trnom.translitgr == TRUE ){
  				preprocessed.text = TraslitAncientGreekLatin( preprocessed.text )
  			}
                	
                	# del arabic numerals
                	preprocessed.text =  delaraNumerals(preprocessed.text )  
                	# ‘ | –⏑–⏑ 
                     	preprocessed.text =  signsleft( preprocessed.text )  
                     	#UNterpunkt
                	preprocessed.text =  delUnterpunkt( preprocessed.text )  
                
                	#
                	return(preprocessed.text)
        }
        
        preprocessed.text = wrapper(input.text, trnom.disambidia,
		trnom.repbehau, trnom.expael,
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
		trnom.klam,trnom.uv,trnom.ji,trnom.hyph, trnom.alphapriv)
        #demUsage( )
        #print("IN TN.NOR")
        #cat(preprocessed.text)
        #print( sghja ) 
        return(preprocessed.text)
}
