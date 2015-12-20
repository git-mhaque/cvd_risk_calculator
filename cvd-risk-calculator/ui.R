library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Risk Calculator for Cardiovascular Disease (CVD)"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Enter age", min = 20, max = 100, value = 50),
      selectInput("gender", "Gender", choices = list("Male" = 0, "Female" = 1), selected = 0),
      selectInput("smoker", "Is smoker?", choices = list("No" = 0, "Yes" = 1), selected = 0),
      selectInput("diabetes", "Has diabetes?", choices = list("No" = 0, "Yes" = 1), selected = 0),
      numericInput("sbp", "Systolic blood pressure (mmHg)", value = 120),
      numericInput("hdlc", "HDL cholesterol (mmol/L)", value = 1.8),
      numericInput("totalc", "Total cholesterol (mmol/L) ", value = 5.6)
    ),
    
    mainPanel(
      htmlOutput("risk"),
      hr(),
      plotOutput("plotRisk")
    )
  )
))