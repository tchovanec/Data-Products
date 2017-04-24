#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {
  
  # Show the cars that relate to the selected filters
  output$table <- renderDataTable({
    
    
    
    # This will create a sequence of values to be used in the filter function below. For example, if a user
    # used the slider and input a min of 50 and a max of 55, this will create a vector of data that will look 
    # like 50,51,52,53,54,55
    horsepower_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
  
    car_data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                      GasCost = input$dist/mpg*input$gas_cost,
                      Cylinders = cyl, Horsepower = hp, 
                      Transmission = am)
    car_data <- filter(car_data, GasCost <= input$max_gas_cost, Cylinders %in% input$cyl, 
                    Horsepower %in% horsepower_seq, Transmission %in% input$am)
    car_data <- mutate(car_data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    car_data <- arrange(car_data, GasCost)
    car_data
    
    # These options will allow the user to the see either 5,15,30,45,60 or 100 results at one time
  }, options = list(lengthMenu = c(5, 15, 30, 45, 60, 100), pageLength = 25))
})
