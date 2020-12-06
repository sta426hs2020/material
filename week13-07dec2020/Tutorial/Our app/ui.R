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
