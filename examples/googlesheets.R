

maxWords<-10

server <- function(input, output) {
  
  # adding data from sheets
  # - authenticate by 'tidyverse-googlesheets'
  # - gs_title searches simply for the google sheet by name! Amazing.
  sheet <- gs_title("Word Graph")
  data <- gs_read_csv(sheet)
  
  
  # randomising 
  randInd<- sample(nrow(data), maxWords, replace=FALSE)
  questions<- data[randInd,]

  
  output$table <- renderDataTable({
    questions
  })
  
  id<-UUIDgenerate()
  # must check if thhere is anythihng 
  gs_upload(write.csv(questions),id)
}

ui <- fluidPage(
        mainPanel(dataTableOutput('table'))

)

shinyApp(ui = ui, server = server)
