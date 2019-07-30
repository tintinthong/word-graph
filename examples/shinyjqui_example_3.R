server <- function(input, output) {
  
  obj<-reactive({
    input$foo_order
    input$bar_order
  })
  
  observe({
    print(obj())
  })
  output$order <- renderPrint({input$foo_order})
}

ui <- fluidPage(
  orderInput(inputId = 'foo', label = 'A simple example', items = c('A', 'B', 'C')),
  orderInput(inputId='bar',label='try to drag',items=c('a','b','c')),
  verbatimTextOutput('order')
)

shinyApp(ui, server)