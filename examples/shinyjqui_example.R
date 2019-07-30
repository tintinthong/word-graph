server <- function(input, output) {
  output$order <- renderPrint({ print(input$dest_order) })
}

ui <- fluidPage(
  orderInput('source', 'Source', items = month.abb,
             as_source = TRUE, connect = 'dest'),
  orderInput('dest', 'Dest', items = NULL, placeholder = 'Drag items here...'),
  verbatimTextOutput('order')
)

shinyApp(ui, server)