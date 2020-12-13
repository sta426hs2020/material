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
