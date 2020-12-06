server.3 <- function(input, output){
  output$histogram <- renderPlot({
    title <- paste(input$num, "Random normal values")
    if(input$check == TRUE){
      hist(rnorm(input$num), main = title)
    }
    else{
      hist(rnorm(100), main = "100 normal values (default setting)")
    }
  })
}