library(shiny)



shinyUI(fluidPage(
  
  titlePanel("Cardiovascular Disease (CVD) Risk Calculator (v1.0)"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Parameters"),
      sliderInput("age",
                  "Age",
                  min = 20,
                  max = 100,
                  value = 50)
    ),
    
    mainPanel(
      textOutput("risk")
    )
  )
))