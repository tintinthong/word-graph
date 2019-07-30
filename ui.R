# 
# ui<-fluidPage(
#   
#   
#   # using shiny js
#   useShinyjs(),
#   
#   # loop through ui
#   lapply(itemsList, function(item) {
#     uiOutput(paste0('sort_', item))
#   }),
#   
#   # textOutput("currentWord"),
#   # textOutput("currentCategory"),
#   
#   
#  
#   
#   
# 
#   # Main Panel
#   mainPanel(
#     
#     fluidRow(
#         #
#         column(width=1,
#                uiOutput(paste0('sort_', item))
#         )
# 
#     ),
#     
#     fluidRow(
#       uiOutput("slider"),
#       htmlOutput("nextWord"),
#       actionButton("submit", "Submit"),
#       actionButton("finish","Finish")
#     )
#     
#  
#     
#     
#     #slider
#     #- current word
#     #- current category
#     #- next word 
#     
#     # fluidRow(
#     #   column(4,offset=4,align="center",
#     #          sliderInput("score", "Score:",min = 1, max = 7,value = 4),
#     #          actionButton("button", "Submit")
#     #          )
#     # )
#     
#     #finish button at the side
#     
#     
#     
#     
#   )
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
#   
# )

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