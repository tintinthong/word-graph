
# USE THIS EXAMPLE AS REFERENCE -- IMPORTANTZ

itemsList<-c('one','two','three','four')


server <- function(input, output) {
  
  
  output$sort1<-renderUI({
         orderInput(itemsList[1], 'one', items = items()$one,
                    connect= itemsList[itemsList!='items1'], item_class = 'info')
    })
    
  output$sort2<-renderUI({
    orderInput(itemsList[2], 'two', items = items()[['two']],
               connect =itemsList[itemsList!='items2'], item_class = 'primary')
  })
  

  items<-eventReactive(
    input$submit,{
      
      
      
      obj<-list(
        'one'=input$one_order,
        'two'=input$two_order
      )
      
      if(input$numberIn==1){
        obj$one<-c(obj$one,input$numberIn)
      }else {
        obj$two<-c(obj$two,input$numberIn)
      }
      
      
   
      return(
        obj
        )
    }
  )


}

ui<-fluidPage(

  sliderInput("numberIn", "Score:",min = 1, max = 7,value = 4),
  actionButton("submit", "Submit"),

  
  uiOutput('sort1'),
  uiOutput('sort2')
)

shinyApp(ui, server)
