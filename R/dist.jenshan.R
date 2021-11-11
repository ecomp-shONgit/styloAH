
# Jensen Shannon Distance, stylo AHE 
#
# Argument: a matrix or data table containing at least 2 rows and 2 cols 
#
#  m= v1+v2/2 JSD = Sum0..i (1/2*v1_xi*(v1_xi/m)+1/2*v2_xi*(v2_xi/m))

dist.jenshan <- 
function( x, exp = 1.5, scale = TRUE ){
    # test if the input dataset is acceptable
    if( is.matrix( x ) == FALSE & is.data.frame( x ) == FALSE ){
        stop("cannot apply a distance measure: wrong data format!")
    }
    # then, test whether the number of rows and cols is >1
    if( length( x[1,] ) < 2 | length(x[,1]) < 2 ){
        stop("at least 2 cols and 2 rows are needed to compute a distance!")
    }  
    # for each t1 and t2 in the matrix computer the dcor
    le <- nrow(x)
    
    rn <- row.names(x)

    y <- matrix(1:(le*le), nrow = le, dimnames = list(rn, rn))

    for( n in 1:le ){
        for( m in 1:le ){
                if(m != n){
                   y[n,m] = makejenshan( x[n,], x[m,])
                } else if( m < n ){ 
                   y[n,m] = y[n,m]
                } else {
                   y[n,m] = 1.0 # unequal to self as a definition
                }
        }
    }
    
    return(y)
    
    
}

makejenshan <- function( v1, v2 ){
    ll <- length(v1)
    sdiver = 0.0
    rdiver = 0.0
    m <- rep(0.0, ll)

    for( n in 1:ll ){
        m[n] = (v1[n]+v2[n])/2
    }
    for( n in 1:ll ){
        sdiver = sdiver+(v1[n]*log10(v1[n]/m[n]))/2
        rdiver = rdiver+(v2[n]*log10(v2[n]/m[n]))/2
    }
    return( sdiver+rdiver )
}
