library(shiny)

calculateRisk <- function(age) {
  
  return (age/2)
  
}



shinyServer(function(input, output) {
    
  output$risk <- renderText(  calculateRisk(as.numeric(input$age))   ) 
  
  
})