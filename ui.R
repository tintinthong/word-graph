

ui<-fluidPage(
  
  # using shiny js
  useShinyjs(),
  
  # loop through ui
  fluidRow(align="center",
    lapply(itemsList, function(item) {
      uiOutput(paste0('sort_', item))
    })
  ),
  
  # textOutput("currentWord"),
  # textOutput("currentCategory"),
  
  
  # make this render UI maybe
  fluidRow(
    column(4,uiOutput("slider"),offset=4
           ),
    column(2,actionButton("submit", "Submit"), offset=8),
    column(2, actionButton("finish","Finish"),offset=8)
  ),
  fluidRow(
    column(2,htmlOutput("nextWord"),offset=4)
  )

  
)