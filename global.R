
#loading libraries
library('shinyWidgets')
library('shinyjs')
library('shinyjqui')

#configure variables
itemsList<-c('one','two','three','four','five','six','seven')
names(itemsList)<-itemsList

maxWords<-5

btx <- c("less","<<","<","< ? >",">",">>","more")  
btx_lookup<-seq(1,7)

#test data
testData=data.frame(
  category=c("aggressive","docile","aggressive","docile","docile","aggressive"),
  word=c("whatever","hello","tool","laptop","bright","television")
)
