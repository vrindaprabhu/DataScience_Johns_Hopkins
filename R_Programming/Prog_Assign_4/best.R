# http://dr-k-lo.blogspot.in/2013/11/in-in-r-underused-in-operator.html

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

best <- function(state, outcome) {
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = F)
  
  check.outcome <- c('heart attack', 'heart failure', 'pneumonia')
  check.state <- unique(outcome.data$State)
  
  ## Check that state and outcome are valid
  if(!(outcome %in% check.outcome)) {
    stop('invalid outcome')
  }
  
  if(!(state %in% check.state)) {
    stop('invalid state')
  }
  
  outcome.data
#   ## Return hospital name in that state with lowest 30-day death
#   check.data <- outcome.data[,c(2,23,17,11)]
#  # good.data <-  check.data[complete.cases(check.data),]
#   #good.data
#  check.data
  
  mat <- data[(data[,2] == state),]
  mat
  
#   good <- mat)
#   awesome <- mat[good,]
#   awesome
#   
#   
#   inds <- arrayInd(which.min(awesome), dim(awesome))
#   inds
  
  
  ## rate
  
  
}


#11,17,23