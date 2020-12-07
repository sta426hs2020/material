library(shiny)
ui <- fluidPage("Hello world!")
server <- function(input, output) {} 
shinyApp(ui = ui, server = server)


ui.1 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100)
)

shinyApp(ui = ui.1, server = server)


# adding more inputs
ui.2 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100),
  checkboxInput(inputId = "check", 
                label = "Are you ready?",
                value = FALSE),
  numericInput(inputId = "numericInput",
               label = "Enter your age:",
               min = 20, max = 50, step = 1, value = 24)
)

shinyApp(ui = ui.2, server = server)


# Adding outputs
ui.3 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100),
  checkboxInput(inputId = "check", 
                label = "Are you ready?",
                value = FALSE),
  numericInput(inputId = "numericInput",
               label = "Enter your age:",
               min = 20, max = 50, step = 1, value = 24),
  plotOutput(outputId = "histogram")
)

server.1 <- function(input, output){
  output$histogram <- renderPlot({
    title <- paste(input$num, "Random normal values")
    hist(rnorm(input$num), main = title)
  })
}

shinyApp(ui = ui.3, server = server.1)


# Using the checkbox as a condition
server.2 <- function(input, output){
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

shinyApp(ui = ui.3, server = server.2)


# What to do with the resampling?

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

shinyApp(ui = ui.3, server = server.3)




# adding stats to the ui
ui.4 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100),
  checkboxInput(inputId = "check", 
                label = "Are you ready?",
                value = FALSE),
  numericInput(inputId = "numericInput",
               label = "Enter your age:",
               min = 20, max = 50, step = 1, value = 24),
  plotOutput(outputId = "histogram"),
  verbatimTextOutput("stats")
)


server.4 <- function(input, output){
  output$histogram <- renderPlot({
    title <- paste(input$num, "Random normal values")
    if(input$check == TRUE){
      hist(rnorm(input$num), main = title)
    }
    else{
      hist(rnorm(100), main = "100 normal values (default setting)", breaks = 20)
    }
  })
  output$stats <- renderPrint({
    summary(rnorm(input$num))
  })
}


shinyApp(ui = ui.4, server = server.4)
# But the stats and the histogram are not coming from the same distribution
# How to solve it?


server.5 <- function(input, output){
  
  data <- reactive({ rnorm(input$num) })
  output$histogram <- renderPlot({
    title <- paste(input$num, "Random normal values")
    if(input$check == TRUE){
      hist(data(), main = title)
    }
    else{
      hist(rnorm(100), main = "100 normal values (default setting)", breaks = 20)
    }
  })
  output$stats <- renderPrint({
    summary(data())
  })
}

shinyApp(ui = ui.4, server = server.5)
# Reactive expressions cache their values
# (the expression will return its most recent value, unless it has become invalidated)


# How to make reactive objects not reactive? isolate()


# Action button


ui.5 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100),
  checkboxInput(inputId = "check", 
                label = "Are you ready?",
                value = FALSE),
  numericInput(inputId = "numericInput",
               label = "Enter your age:",
               min = 20, max = 50, step = 1, value = 24),
  actionButton(inputId = "clicks", label = "Click me"),
  plotOutput(outputId = "histogram"),
  verbatimTextOutput("stats")
)

# Trigger an event with observeEvent()
# Printing something on R terminal
server.6 <- function(input, output){
  
  data <- reactive({ rnorm(input$num) })
  output$histogram <- renderPlot({
    title <- paste(input$num, "Random normal values")
    if(input$check == TRUE){
      hist(data(), main = title)
    }
    else{
      hist(rnorm(100), main = "100 normal values (default setting)", breaks = 20)
    }
  })
  output$stats <- renderPrint({
    summary(data())
  })
  observeEvent(input$clicks, { print(as.numeric(input$clicks))
  })
}

shinyApp(ui = ui.5, server = server.6)
# The value is an integer that changes each time a user clicks the button



# Can we prevent the graph from updating until we hit the button?
# Use eventReactive() to delay reactions
# eventReactive() creates a reactive expression
# You can specify precisely which reactive values should invalidate the expression

ui.6 <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 25, min = 1, max = 100),
  sliderInput(inputId = "nbreaks",
              label = "Number of breaks in the histogram",
              value = 20, min = 1, max = 100),
  checkboxInput(inputId = "check", 
                label = "Check this if you want to set the sample size",
                value = FALSE),
  actionButton(inputId = "go", label = "Update"),
  plotOutput(outputId = "histogram"),
  verbatimTextOutput("stats")
)

server.7 <- function(input, output){
  
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

shinyApp(ui = ui.6, server = server.7)


# Managing states
# You cannot change what user chooses in the slider
# use reactiveValues()


ui.7 <- fluidPage(
  actionButton(inputId = "unif", label = "Uniform"),
  actionButton(inputId = "Normal", label = "Normal"),
  plotOutput(outputId = "histogram")
)

server.8 <- function(input, output){
  
  rv <- reactiveValues(data = rnorm(100))
  
  observeEvent(input$Normal, { rv$data <- rnorm(100) }) 
  observeEvent(input$unif, { rv$data <- runif(100) })
  output$histogram <- renderPlot({ hist(rv$data, breaks = 20)})
}
shinyApp(ui = ui.7, server = server.8)
