
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)

library(plyr)

someList<-list(one=c('word1','word2','word3'),two=c('word5','word4'),three=NULL)


#word.list <- list(letters[1:4], letters[1:5], letters[1:2], letters[1:6])

# removing null values
someList[sapply(someList, is.null)] <- NULL

n.obs <- sapply(someList, length)
seq.max <- seq_len(max(n.obs))

mat <- sapply(someList, "[", i = seq.max)

as_tibble(mat)%>% gather("score","word")%>%drop_na()


