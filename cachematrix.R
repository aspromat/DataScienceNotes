

## This function creates a special object that stores a matrix

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  #Setting the value of the matrix
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  #Get matrix value
  get <- function() x
  #Set value of inverse
  setinv <- function(inverse) i <<- inverse
  #Get value of inverse
  getinv <- function() i
  list(set = set,
       get = get,
       setinv = setinv,
       getinv = getinv)
}


## compute the inverse matrix that is stored in the cache

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  i <- x$getinv()
  if (!is.null(i)) {
    message("getting chached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinv(i)
  i
}

