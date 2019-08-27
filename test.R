
word_graph<-matrix(rep(NA,12),ncol=3)


word_obj<- list(
  
  col1=c(1,2,3),
  col2=c(4,2),
  col3=c(1,2,4,5)
  
  
)

x<-2
paste(x)

paste0(1:12)
paste(month.abb, "is the", nth, "month of the year.")

(nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9))))

x<-10
paste0(x,"th")

res <- lapply(1:5, function(i) input[[paste0('a', i)]])

itemsList
for(i in 1:length(itemsList) ){print(paste0(itemsList[i],"_order"))}


randList<-lapply(itemsList, function(item){
  paste0(item,"_order")
})
names(randList)<-itemsList


obj<-lapply(itemsList, function(item){
  get(paste0("input$",item,"_order"))
})
names(obj)<-itemsList

randList



# loop through to render UI

# for(item in itemsList){
#   
#   # using local so item does not return last element of render function
#   local({
# 
#   itemPrime<-item
#   output[[paste0("sort_",itemPrime)]]<-renderUI({
#     orderInput(itemPrime, itemPrime, items = items()[[itemPrime]],
#                connect= itemsList[itemsList!=itemPrime], item_class = 'info')
#     }) 
#   
#   
#   
#   })
# }

my.list <- list(name = c("A", "B", "C"), age = c(20, 30, 40, 50))
sum(lengths(my.list))

column(width=1,
       orderInput(itemsList[1], 'Items1', items = month.abb , width='50px', 
                  connect= itemsList[itemsList!='items1'], item_class = 'info')
       
),
column(width=1,
       # h3("haa")
       ## build connections between orderInputs
       orderInput(itemsList[2], 'Items2', items = month.abb[1:2], width='50px',
                  connect =itemsList[itemsList!='items2'], item_class = 'primary')
       
),
column(width=1,
       # h3("haa")
       ## build connections in source mode
       orderInput(itemsList[3], 'Items3', items = month.abb, width='50px',
                  connect =itemsList[itemsList!='items3'], item_class = 'success')
       
),
column(width=1,
       ## show placeholder
       orderInput(itemsList[4], 'Items4', items = NULL, width='50px',
                  connect =itemsList[itemsList!='items4'], item_class = 'warning')
)

