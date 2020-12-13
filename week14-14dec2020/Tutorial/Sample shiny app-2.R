library(shiny)
library(rsconnect)

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



## Start of the second part of the shiny tutorial

names(tags)
tags$h1()
tags$a(href = "www.rstudio.com", "RStudio")

# You can also use paste
# You can nest the tags inside of each other

# How to make reactive objects not reactive? isolate()


# Action button


ui.5 <- fluidPage(
  tags$h1("Normal distribution visualizer"),
  tags$p("This shiny app visualizes the distribution of i.i.d",
         tags$strong("normally distributed random variables"), 
         "in a hisogram. It is hosted on"),
  tags$a(href = "https://ahmadreza.shinyapps.io/our_app/", "this link"),
  tags$hr(),
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

shinyApp(ui = ui.5, server = server.5)


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
  tags$h1("Normal distribution visualizer"),
  tags$p("This shiny app visualizes the distribution of i.i.d",
         tags$strong("normally distributed random variables"), 
         "in a hisogram. It is hosted on"),
  tags$a(href = "https://ahmadreza.shinyapps.io/our_app/", "this link"),
  tags$hr(),
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

# Adding panels
# Groups elements into a grey "well"

ui.7 <- fluidPage(
  tags$h1("Normal or uniform?"),
  wellPanel(
  actionButton(inputId = "unif", label = "Uniform"),
  actionButton(inputId = "Normal", label = "Normal")),
  plotOutput(outputId = "histogram")
)

server.8 <- function(input, output){
  
  rv <- reactiveValues(data = rnorm(100))
  
  observeEvent(input$Normal2, { rv$data <- rnorm(100) }) 
  observeEvent(input$unif2, { rv$data <- runif(100) })
  output$histogram <- renderPlot({ hist(rv$data, breaks = 20)})
}
shinyApp(ui = ui.7, server = server.8)


# Adding 
# tabPanel() creates a stackable layer of elements. Each tab is like a small UI of its own.


ui.8 <- fluidPage(
  tabsetPanel(
  tabPanel("Actionbuttons",
           tags$h1("Normal or uniform?"),
  wellPanel(
    actionButton(inputId = "unif2", label = "Uniform"),
    actionButton(inputId = "Normal2", label = "Normal")),
  plotOutput(outputId = "histogram2")),
  tabPanel("Normal visualizer",
              tags$h1("Normal distribution visualizer"),
              tags$p("This shiny app visualizes the distribution of i.i.d",
                     tags$strong("normally distributed random variables"), 
                     "in a hisogram. It is hosted on"),
              tags$a(href = "https://ahmadreza.shinyapps.io/our_app/", "this link"),
              tags$hr(),
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
              verbatimTextOutput("stats"))
  )
)

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
shinyApp(ui = ui.8, server = server.9)


# Navbar
ui.9 <- fluidPage(
  navlistPanel(
    tabPanel("Actionbuttons",
             tags$h1("Normal or uniform?"),
             wellPanel(
               actionButton(inputId = "unif2", label = "Uniform"),
               actionButton(inputId = "Normal2", label = "Normal")),
             plotOutput(outputId = "histogram2")),
    tabPanel("Normal visualizer",
             tags$h1("Normal distribution visualizer"),
             tags$p("This shiny app visualizes the distribution of i.i.d",
                    tags$strong("normally distributed random variables"), 
                    "in a hisogram. It is hosted on"),
             tags$a(href = "https://ahmadreza.shinyapps.io/our_app/", "this link"),
             tags$hr(),
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
             verbatimTextOutput("stats"))
  )
)

shinyApp(ui = ui.9, server = server.9)


# Free themese for bootstrap
# https://bootswatch.com


ui.10 <- fluidPage(
  includeCSS("./www/bootstrap.min.css"),
  tabsetPanel(
    tabPanel("Actionbuttons",
             tags$h1("Normal or uniform?"),
             wellPanel(
               actionButton(inputId = "unif2", label = "Uniform"),
               actionButton(inputId = "Normal2", label = "Normal")),
             plotOutput(outputId = "histogram2")),
    tabPanel("Normal visualizer",
             tags$h1("Normal distribution visualizer"),
             tags$p("This shiny app visualizes the distribution of i.i.d",
                    tags$strong("normally distributed random variables"), 
                    "in a hisogram. It is hosted on"),
             tags$a(href = "https://ahmadreza.shinyapps.io/our_app/", "this link"),
             tags$hr(),
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
             verbatimTextOutput("stats"))
  )
)

shinyApp(ui = ui.10, server = server.9)
rsconnect::deployApp(account = 'ahmadreza', './Our app/')
