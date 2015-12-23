
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  ## file.directory gives the location of the CSV files
  file.directory <- file.path(getwd(),directory)
  
  ## file.list gives list of all CSV files
  files.list <- list.files(file.directory)
  means <- numeric()
  for(i in files.list[id]) {
    id.csv <- read.csv(file.path(file.directory,i))
    means <- c(means,id.csv[,pollutant])
  }
  round(mean(means,na.rm = T),3)

}


completeV1 <- function(directory, id = 1:332) {
  
  ## file.directory gives the location of the CSV files
  file.directory <- file.path(getwd(),directory)
  
  ## file.list gives list of all CSV files
  files.list <- list.files(file.directory)
  complete.list <- data.frame()
  
  for(i in files.list[id]) {
    
    id.csv <- read.csv(file.path(file.directory,i))
    good <- complete.cases(id.csv) # Gets non-na row indices
    rows <- nrow(id.csv[good,])

    files.rownumbs <- as.data.frame(i,rows)
    complete.list <- rbind(complete.list,files.rownumbs)
    
  }
  complete.list
}


complete <- function(directory, id = 1:332) {
  
  ## file.directory gives the location of the CSV files
  file.directory <- file.path(getwd(),directory)
  
  ## file.list gives list of all CSV files
  files.list <- list.files(file.directory)
  complete.list <- data.frame()
  id.names <- character()
  nobs <- numeric()
  
  for(i in files.list[id]) {
    id.csv <- read.csv(file.path(file.directory,i))
    good <- complete.cases(id.csv) # Gets non-na row indices
    rows <- nrow(id.csv[good,])
    
    id.names <- c(id.names,i)
    nobs <- c(nobs,rows)
  }

  id <- id.names
  complete.list <- as.data.frame(cbind(id,nobs))
  complete.list
}


corr <- function(directory, threshold = 0) {
  
  ## file.directory gives the location of the CSV files
  file.directory <- file.path(getwd(),directory)
  
  ## file.list gives list of all CSV files
  files.list <- list.files(file.directory)
  correlate.list <- numeric()
  
  for(i in files.list) {
    id.csv <- read.csv(file.path(file.directory,i))
    good <- complete.cases(id.csv) # Gets non-na row indices
    good.csv <- id.csv[good,]
    rows <- nrow(good.csv)
    
    if(rows > threshold) {
      correlate.list <- c(correlate.list,cor(good.csv$sulfate,good.csv$nitrate))
    }    
  }
  correlate.list 
}


