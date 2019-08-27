

ui<-fluidPage(
  
  # using shiny js
  useShinyjs(),
  
  fluidRow(align="center",
    column(4, 
           titlePanel('Word Context Matching')
           ,offset=4)
  ),
  
  # loop through ui
  fluidRow(align="center",
    lapply(itemsList, function(item) {
      uiOutput(paste0('sort_', item))
    })
  ),
  
  # textOutput("currentWord"),
  # textOutput("currentCategory"),
  
  
  # make this render UI maybe
  fluidRow(align="center",
    column(4,uiOutput("slider"),offset=4)
  ),
  fluidRow(align="center",
           column(4,htmlOutput("nextWord"),offset=4)
  ),
  fluidRow(align="center",
           column(4,actionButton("submit", "Submit"),offset=4),
           column(4, actionButton("finish","Finish"),offset=4)
  )

  
)