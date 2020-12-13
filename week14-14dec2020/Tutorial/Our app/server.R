server.9 <- function(input, output){
  
  rv <- reactiveValues(data = rnorm(100))
  
  observeEvent(input$Normal2, { rv$data <- rnorm(100) })
  observeEvent(input$unif2, { rv$data <- runif(100) })
  output$histogram2 <- renderPlot({ hist(rv$data, breaks = 20)})
  
  data <- eventReactive(input$go, { rnorm(input$num) })
  sampSize <- eventReactive(input$go, {input$num})
  nbreaks <- eventReactive(input$go, {input$nbreaks})
  # Remember that the output is a closure
  
  output$histogram <- renderPlot({
    if(input$check == TRUE){
      title <- paste(sampSize(), "Random normal values")
      hist(data(), main = title, breaks = nbreaks())
    }
    else{
      hist(rnorm(100), main = "100 normal values (default setting, break = 20)", breaks = 20)
    }
  })
  output$stats <- renderPrint({
    if(input$check == TRUE){
      summary(data())
    }
  })

}
