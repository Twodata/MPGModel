
library(shiny)
library(dplyr)
library(stats)


data(mtcars)


mtcars <- select(mtcars, mpg, disp, hp, wt)

model <- lm(mpg ~., mtcars)




ui <- fluidPage(
  headerPanel(wellPanel('MPG Prediction Model')),
  sidebarLayout(
    sidebarPanel(
      fluidRow(column(12, h2('Input Data'))),
      numericInput('disp', 'Enter displacement value', min = 70.0, max = 500.0, value = 0),
      numericInput('hp', 'Enter horsepower value', min = 50, max = 400, value = 0 ),
      numericInput('wt', 'Enter weight value', min = 1.600, max = 6.000, value = 0),
      submitButton('Submit values')
      
    ),
    mainPanel(wellPanel(fluidRow(column(12, h1('MPG Value', align = 'center')))), 
              hr(),
              br(),
              wellPanel(fluidRow(h1(column(4, tableOutput('pred'), offset = 4)))
  )
)))






server <- function(input, output){
  output$pred <- renderPrint({
    cat(round(predict(model, data.frame(disp = input$disp, hp = input$hp, wt = input$wt)), 2))
  })
  
}




shinyApp(ui = ui, server = server)





