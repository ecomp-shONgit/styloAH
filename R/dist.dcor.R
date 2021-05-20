
# Distance Correlation, stylo AHE 
#
# Argument: a matrix or data table containing at least 2 rows and 2 cols 
Akl <- 
function(x, index) {
    d <- as.matrix(x)^index
    m <- rowMeans(d)
    M <- mean(d)
    a <- sweep(d, 1, m)
    b <- sweep(a, 2, m)
    return( b + M )
}
    
DCOR <-
function(x, y, index=1.0) {
    # TAKEN FROM energy R package, Maria Rizzo and Gabor Szekely
    # distance covariance and correlation statistics
    # alternate method, implemented in R without .C call
    # this method is usually slower than the C version
  
    if (!inherits(x, "dist")) x <- dist(x)
    if (!inherits(y, "dist")) y <- dist(y)
    x <- as.matrix(x)
    y <- as.matrix(y)
    n <- nrow(x)
    m <- nrow(y)
    if (n != m) stop("Sample sizes must agree")
    if (! (all(is.finite(c(x, y)))))
        stop("Data contains missing or infinite values")
    if (index < 0 || index > 2) {
        warning("index must be in [0,2), using default index=1")
        index=1.0}

    stat <- 0
    dims <- c(n, ncol(x), ncol(y))

    

    A <- Akl(x, index)
    B <- Akl(y, index)
    dCov <- sqrt(mean(A * B))
    dVarX <- sqrt(mean(A * A))
    dVarY <- sqrt(mean(B * B))
    V <- sqrt(dVarX * dVarY)
    if (V > 0)
      dCor <- dCov / V else dCor <- 0
    return(list(dCov=dCov, dCor=dCor, dVarX=dVarX, dVarY=dVarY))
}

dist.dcor <- 
function( x, exp = 1.5, scale = TRUE ){

    # test if the input dataset is acceptable
    if( is.matrix( x ) == FALSE & is.data.frame( x ) == FALSE ){
        stop("cannot apply a distance measure: wrong data format!")
    }
    # then, test whether the number of rows and cols is >1
    if( length( x[1,] ) < 2 | length(x[,1]) < 2 ){
        stop("at least 2 cols and 2 rows are needed to compute a distance!")
    }


    
    # scaled ???
    #if(scale == TRUE) {
    #    x = scale(x)
    #} 
    
    

    # for each t1 and t2 in the matrix computer the dcor
    # 
    le <- nrow(x)
    
    rn <- row.names(x)

    y <- matrix(1:(le*le), nrow = le, dimnames = list(rn, rn))

    for( n in 1:le ){
        for( m in 1:le ){
                if(m != n){
                   cccc = DCOR( x[n,], x[m,], exp )
                   dcccc = 1-cccc$dCor
                   y[n,m] = dcccc
                } else if( m < n ){ #little speedup
                   y[n,m] = y[n,m]
                } else {
                   y[n,m] = 1.0 # unequal to self as a definition
                }
        }
    }
    
    return(y)
    
    
}
