

# Hellinger Distance, stylo AHE 
#
# Argument: a matrix or data table containing at least 2 rows and 2 cols 
#


dist.helli <- 
function( x ){
    # test if the input dataset is acceptable
    if( is.matrix( x ) == FALSE & is.data.frame( x ) == FALSE ){
        stop("cannot apply a distance measure: wrong data format!")
    }
    # then, test whether the number of rows and cols is >1
    if( length( x[1,] ) < 2 | length(x[,1]) < 2 ){
        stop("at least 2 cols and 2 rows are needed to compute a distance!")
    }

    # for each t1 and t2 in the matrix computer the dcor
    # 
    le <- nrow(x)
    
    rn <- row.names(x)

    y <- matrix(1:(le*le), nrow = le, dimnames = list(rn, rn))
    #print(x)
    for( n in 1:le ){

        for( m in 1:le ){
                
                if( m != n ){
                   y[n,m] = hellinger(x[n,], x[m,], -Inf, Inf)#1-hellinger(x[n,], x[m,], -Inf, Inf)
                } else if( m < n ){ 
                   y[n,m] = y[n,m]
                } else {
                   y[n,m] = 1.0 # unequal to self as a definition
                }
        }
    }
    return(y)
}
