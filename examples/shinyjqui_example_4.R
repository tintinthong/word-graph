
#loading libraries
library('shinyWidgets')
library('shinyjs')
library('shinyjqui')

#configure variables
itemsList<-c('one','two','three','four','five','six','seven')
names(itemsList)<-itemsList
btx <- c("less","<<","<","< ? >",">",">>","more")  
btx_lookup<-seq(1,7)
maxWords<-5

#load data
testData=data.frame(
  category=c("aggressive","docile","aggressive","docile","docile","aggressive"),
  word=c("whatever","hello","tool","laptop","bright","television")
)

server <- function(input, output, session) {
  
  # loading testData and randomising

  shinyjs::hide("finish")
  
  wordNo<-reactiveValues(count=1)
  
  # word<-reactiveValues(value=paste(testData$word[wordNo$count]))
  
  lapply(itemsList,function(item){
    output[[paste0("sort_",item)]]<-renderUI({
      orderInput(item,item,items=items()[[item]],
                 connect=itemsList[itemsList!=item],item_class='info')
    })
  })
  
  mainObj<-reactive({
    lapply(itemsList, function(item){
      eval(parse(text=paste0("input$",item,"_order")))
    })
  })
  
  output$slider<-renderUI({
    sliderTextInput("sliderInput",
                    label=div(style='width:300px;', 
                              div(style='float:left;',  paste(testData$word[wordNo$count])), 
                              div(style='float:right;color:blue;', paste(testData$category[wordNo$count]))
                              ),  # cat may have
                    selected = btx[4],        # gotten text, use <-
                    choices = btx, 
                    hide_min_max = FALSE) 
    
  })

  
  # use event Reactive to detect button click
  items<-eventReactive(
    
    input$submit,{
      
      word<-paste(testData$word[wordNo$count])
      numberIn<-btx_lookup[btx %in% input$sliderInput]
      
      # must use eval, parse to convert string into variable
      obj<-lapply(itemsList, function(item){
        eval(parse(text=paste0("input$",item,"_order")))
      })
     
      # change conditionals to strings
      if(numberIn==1){
        obj$one<-c(obj$one,word)
      }else if(numberIn==2) {
        obj$two<-c(obj$two,word)
      }else if(numberIn==3){
        obj$three<-c(obj$three,word)
      }else if(numberIn==4){
        obj$four<-c(obj$four,word)
      }else if(numberIn==5){
        obj$five<-c(obj$five,word)
      }else if(numberIn==6){
        obj$six<-c(obj$six,word)
      }else{
        obj$seven<-c(obj$seven,word)
      }
      
      
      
      wordNo$count<-wordNo$count+1
        
      #return object
      return(
        obj
      )
    }
  )
  
  observeEvent(input$finish,{
        print(mainObj())
    }
  )
  

  # checking for word count exceeding maximum words
  observe({
    if(wordNo$count>maxWords){
      print("maxWords exceeded")
      shinyjs::hide("submit")
      shinyjs::show("finish")
    }
 
    
  })
  
  observe({
    # print(mainObj())
  })
  
  
  #rendering ui elements
    
  output$currentWord<-renderText({
    paste(testData$word[wordNo$count])
   
  })
  output$currentCategory<-renderText({
    paste(testData$category[wordNo$count])
  })
  output$nextWord<-renderText({
   paste("<font color=\"red\"><b>", "Next Word:" , testData$word[wordNo$count+1], "</b></font>") 
  })
    
  
}

ui<-fluidPage(
  
  # using shiny js
  useShinyjs(),
  
  # loop through ui
  lapply(itemsList, function(item) {
    uiOutput(paste0('sort_', item))
  }),
  
  # textOutput("currentWord"),
  # textOutput("currentCategory"),


  # make this render UI maybe
  fluidRow(
    uiOutput("slider"),
    htmlOutput("nextWord"),
    actionButton("submit", "Submit"),
    actionButton("finish","Finish")
  )

 

)

shinyApp(ui, server)
