server <- function(input, output, session) {
  
  #person 
  id<-UUIDgenerate()
  idCount<-1
  
  # loading testData and randomising
  
  shinyjs::hide("finish")
  
  wordNo<-reactiveValues(count=1)
  submitButton<-reactiveValues(clicked=FALSE)
  
  # word<-reactiveValues(value=paste(testData$word[wordNo$count]))
  
  lapply(itemsList,function(item){
    
    output[[paste0("sort_",item)]]<-renderUI({
      if(submitButton$clicked){
        orderInput(inputId=item,label=item,items=items()[[item]],
                   connect=itemsList[itemsList!=item],item_class='info')
      }else{
        orderInput(item,item,items=NULL,
                   connect=itemsList[itemsList!=item],item_class='info')
      }
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
  #-- problem with this is that it has two-way dependency
  #-- items() is a dependent of orderInput, but, input${item}_order us dependent on items()
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
    # ,ignoreNULL = FALSE #trigger event even when button has not been pressed 
  )
  
  observeEvent(input$finish,{
    print(mainObj())
    
    objOut<-mainObj()
    objOut[sapply(objOut, is.null)] <- NULL
    n.obs <- sapply(objOut, length)
    seq.max <- seq_len(max(n.obs))
    mat <- sapply(objOut, "[", i = seq.max)
    dataOut<-as_tibble(mat)%>% gather("score","word")%>%drop_na()
   
    
    # writing file in local computer
    path=paste0("./experiments/",id,".csv")
    write_csv(dataOut,path)
    # # uploading file to google sheets
    sendSweetAlert(session,title="Thank you",text="You have succesffully completed the experiment")
    
    # add loading screen
    gs_upload(path,sheet_title=id,overwrite=TRUE)
   
  })
  
  observeEvent(input$submit,{
    submitButton$clicked<-TRUE
  })
  
  
  # checking for word count exceeding maximum words
  observe({
    if(wordNo$count>maxWords){
      print("maxWords exceeded")
      shinyjs::hide("submit")
      shinyjs::show("finish")
    }
    
    
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


