
#loading libraries
library('shinyWidgets')
library('shinyjs')
library('shinyjqui')
library('uuid')
library(googlesheets)
library(tidyverse)


#configure variables
itemsList<-c('one','two','three','four','five','six','seven')
names(itemsList)<-itemsList

maxWords<-8

btx <- c("less","<<","<","< ? >",">",">>","more")  
btx_lookup<-seq(1,7)

#test data
# testData=data.frame(
#   category=c("aggressive","docile","aggressive","docile","docile","aggressive"),
#   word=c("whatever","hello","tool","laptop","bright","television")
# )

#load data
# adding data from sheets
# - authenticate by 'tidyverse-googlesheets'
# - gs_title searches simply for the google sheet by name! Amazing.
sheet <- gs_title("Word Graph")
data <- gs_read_csv(sheet)


# randomising 
randInd<- sample(nrow(data), maxWords, replace=FALSE)
testData<- data[randInd,]

