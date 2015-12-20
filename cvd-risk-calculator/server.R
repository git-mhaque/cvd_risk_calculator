library(shiny)

calculateRisk <- function(age, sex, isSmoker, hasDiabetes, systolicBloodPressure, hdlCholesterol, totalCholesterol) {
  O1 <- 0.6536
  O2 <- -0.2402
  B0 <- 18.8144
  B1 <- -1.2146
  B2 <- -1.8443
  B3 <- 0
  B4 <- 0.3668
  B5 <- 0
  B6 <- -1.4032
  B7 <- -0.3899
  B8 <- -0.539
  B9 <- -0.3036
  B10 <- -0.1697
  EcgLvh <- -0.3362
  EcgLvhM <- 0
  Lvh <- 0
  T <- 5
    
  u <- B0 +
    (B1 * sex) +
    (B2 * log(age)) +
    (B3 * (log(age)^2)) +
    (B4 * log(age) * sex) +
    (B5 * (log(age)^2) * sex) +
    (B6 * log(systolicBloodPressure)) +
    (B7 * isSmoker) +
    (B8 * log(totalCholesterol / hdlCholesterol)) +
    (B9 * hasDiabetes) +
    (B10 * hasDiabetes * sex) +
    (EcgLvh * Lvh) +
    (EcgLvhM * sex)
  
  p <- 1 - exp(-exp((log(T) - u) / exp(O1 + O2 * u)));
  
  
  return (p*100)
  
}



shinyServer(function(input, output) {

  riskProfile <- reactive({
    selectedAge <- as.numeric(input$age)
    ageMin <- 1;
    ageMax <- 100;
    ageProfile <- array(1:ageMax-ageMin+1) 
    
    index <- 1;
    for (i in ageMin : ageMax)
    {
      ageProfile[index] <- calculateRisk(
        as.numeric(i),
        as.numeric(input$gender),
        as.numeric(input$smoker),
        as.numeric(input$diabetes),
        as.numeric(input$sbp),
        as.numeric(input$hdlc),
        as.numeric(input$totalc)
      );
      index = index + 1;
    }
    
    ageProfile 
  })
  
# output$age <- renderText( paste("Age:",as.numeric(input$age) )) 
#  output$gender <- renderText( paste("Gender:", if(as.numeric(input$gender)==1) "Female" else "Male")) 
#  output$smoker <- renderText( paste("Is smoker?", if(as.numeric(input$smoker)==1) "Yes" else "No")) 
#  output$diabetes <- renderText( paste("Has diabetes?", if(as.numeric(input$diabetes)==1) "Yes" else "No")) 
#  output$sbp <- renderText( paste("Systolic blood pressure (mmHg):",as.numeric(input$sbp) )) 
#  output$hdlc <- renderText( paste("HDL cholesterol (mmol/L):",as.numeric(input$hdlc) )) 
#  output$totalc <- renderText( paste("Total cholesterol (mmol/L):",as.numeric(input$totalc) )) 
  output$risk <- renderText( 
    {
      risk <- calculateRisk(
        as.numeric(input$age),
        as.numeric(input$gender),
        as.numeric(input$smoker),
        as.numeric(input$diabetes),
        as.numeric(input$sbp),
        as.numeric(input$hdlc),
        as.numeric(input$totalc)
      )
      
      risk <- round(risk,digits = 2)
      
      paste("<div class='alert alert-info'><h4>Risk for cardiovascular disease (%):", risk, "</h4></div>")
    }
    ) 
  output$plotRisk <- renderPlot(
    {
      plot(riskProfile(), xlab = "Age", ylab = "Risk (%)", type = "l", main = "Risk at different ages")
      abline(v = as.numeric(input$age), col = "red")
    }
  )
  
})