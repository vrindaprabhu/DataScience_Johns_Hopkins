#https://asitarrives.wordpress.com/2014/10/18/understanding-lexical-scoping-in-r-great-guidance-for-community-ta-in-coursera/
#http://adv-r.had.co.nz/Functional-programming.html

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) i <- inverse
  getinverse <- function() i
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    iessage("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}


a <- makeCacheMatrix(matrix(c(1,2,3,4), nrow = 2, ncol = 2))
a$get()
a$getinverse()
cacheSolve(a)
a$getinverse()

