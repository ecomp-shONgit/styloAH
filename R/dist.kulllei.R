
# Kullback Leibler divergence, stylo AHE 
#
# Argument: a matrix or data table containing at least 2 rows and 2 cols 
#

dist.kulllei <- 
function( x, exp = 1.5, scale = TRUE ){
    # test if the input dataset is acceptable
    if( is.matrix( x ) == FALSE & is.data.frame( x ) == FALSE ){
        stop("cannot apply a distance measure: wrong data format!")
    }
    # then, test whether the number of rows and cols is >1
    if( length( x[1,] ) < 2 | length(x[,1]) < 2 ){
        stop("at least 2 cols and 2 rows are needed to compute a distance!")
    }  
    # for each t1 and t2 in the matrix computer the kullback leibler divergence with D(t1|t2) = Sum_0-i P(t1_xi) * log( P(t1_xi)/P(t2_xi) ) ; 0 is same or not distant

    le <- nrow(x)
    
    rn <- row.names(x)

    y <- matrix(1:(le*le), nrow = le, dimnames = list(rn, rn))

    for( n in 1:le ){
        for( m in 1:le ){
                if( m != n ){
                   y[n,m] = makekulllei( x[n,], x[m,])
                } else {
                   y[n,m] = 1000.0 # unequal to self as a definition
                }
        }
    }
    
    return(y) 
}

makekulllei <- function( v1, v2 ){
    ll <- length(v1)
    sdiver = 0.0
    for( n in 1:ll ){
        message(sdiver, "  ",v1[n]*log10(v1[n]/v2[n]), " v1n ",v1[n], " log ", log10(v1[n]/v2[n]), " v d m ", v1[n]/v2[n], " mn ",v2[n], "\n" )
        if( v1[n] != 0 && v2[n] != 0 ){
            sdiver = sdiver+(v1[n]*log10(v1[n]/v2[n]))
        }
    }
    return( sdiver )
}
