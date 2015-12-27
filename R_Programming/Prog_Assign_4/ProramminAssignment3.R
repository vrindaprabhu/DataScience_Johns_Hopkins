# http://dr-k-lo.blogspot.in/2013/11/in-in-r-underused-in-operator.html

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

best <- function(state, outcome) {
  
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = F)
  
  outcome.list <- list(11, 17, 23)
  names(outcome.list) <- c('heart attack', 'heart failure', 'pneumonia')
  
  check.state <- unique(outcome.data$State)
  
  ## Check that state and outcome are valid
  if(!(outcome %in% names(outcome.list))) {
    stop('invalid outcome')
  }
  
  if(!(state %in% check.state)) {
    stop('invalid state')
  }
  
  ## Return hospital name in that state with lowest 30-day death 
  data.subset <- outcome.data[(outcome.data[,'State'] == state),c(2,outcome.list[[outcome]])] 
  indices <- which(data.subset[,2] == min(as.double(data.subset[,2]),na.rm = T),arr.ind = T)
  data.subset[indices,"Hospital.Name"]
  
}



rankhospital <- function(state, outcome, num = "best") { 
  
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = F)

  outcome.list <- list(11, 17, 23)
  names(outcome.list) <- c('heart attack', 'heart failure', 'pneumonia')
 
  check.state <- unique(outcome.data$State)
  
  ## Check that state and outcome are valid
  if(!(outcome %in% names(outcome.list))) {
    stop('invalid outcome')
  }
  
  if(!(state %in% check.state)) {
    stop('invalid state')
  }
  
  ## Return hospital name in that state with the given rank ## 30-day death rate
  data.subset <- outcome.data[(outcome.data[,'State'] == state),c(2,outcome.list[[outcome]])]
  rank.data <- data.subset[order(data.subset[,2],data.subset[,'Hospital.Name']),]
  if(num == 'best'){
    indices <- which(rank.data[,2] == min(as.double(rank.data[,2]),na.rm = T),arr.ind = T)
    return(rank.data[indices,"Hospital.Name"])
  }
  if(num == 'worst'){
    indices <- which(rank.data[,2] == max(as.double(rank.data[,2]),na.rm = T),arr.ind = T)
    return(rank.data[indices,"Hospital.Name"])
  }
  rank.data[num,"Hospital.Name"]
  
}



rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = F)
  
  outcome.list <- list(11, 17, 23)
  names(outcome.list) <- c('heart attack', 'heart failure', 'pneumonia')
  
  check.state <- unique(outcome.data$State)
  
  ## Check that outcome is valid
  if(!(outcome %in% names(outcome.list))) {
    stop('invalid outcome')
  }

  ## Return hospital name in that state with the given rank ## 30-day death rate
  data.subset <- outcome.data[order(outcome.data[,outcome.list[[outcome]]],outcome.data[,'Hospital.Name']),
                           c(2,outcome.list[[outcome]],grep("State", colnames(outcome.data)))]
  rank.data <- split(data.subset,data.subset$State )
  
  if(num == 'best') {
    hospital.matrix <- sapply(check.state,function(x){
      indices <- which(rank.data[[x]][,2] == min(as.double(rank.data[[x]][,2]),na.rm = T),arr.ind = T)
      hospital.name <- rank.data[[x]][indices,c("Hospital.Name","State")]
      hospital.name[order(hospital.name[,1])[1],]
    })
    rownames(hospital.matrix) <- c('hospital','state')
    return(as.data.frame(t(hospital.matrix)))
  }
  
  if(num == 'worst') {
    hospital.matrix <- sapply(check.state,function(x){
      indices <- which(rank.data[[x]][,2] == max(as.double(rank.data[[x]][,2]),na.rm = T),arr.ind = T)
      hospital.name <- rank.data[[x]][indices,c("Hospital.Name","State")]
      hospital.name[order(hospital.name[,1])[1],]
    })
    rownames(hospital.matrix) <- c('hospital','state')
    return(as.data.frame(t(hospital.matrix)))
  }
  
  hospital.matrix <- sapply(check.state,function(x){c(rank.data[[x]][num,c("Hospital.Name")],x)})
  rownames(hospital.matrix) <- c('hospital','state')
  return(as.data.frame(t(hospital.matrix)))
  
}



