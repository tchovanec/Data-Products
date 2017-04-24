#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(markdown)

shinyUI(navbarPage("Car Selection For Your Vacation Trip",
                   tabPanel("Table",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Please provide information about your trip and any specs in a car you would like."),
                                
                                # Starts the default value at 40 miles and allows a max of 2000 and a min of 10
                                numericInput('dist', 'Distance (in miles):', 40, min = 10, max = 2000),
                                
                                # Starts the default gas price at 2 with a minumum of 1.90 and max of 7. Incrmenets the price by 0.01
                                numericInput('gas_cost', 'Price of Gas (per gallon):', 2.00, min = 1.90, max = 7, step=0.01),
                                
                                # Max money spent on gas defaults to 25 with a min of 1 and a max of 1000
                                numericInput('max_gas_cost', 'Max money spent on gas for trip:', 25, min=1, max=1000),
                                
                                # creates a checkbox to allow the selection of either an automatic or manual transmission
                                checkboxGroupInput('am', 'Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1)),
                                
                                # Creates a checkbox to allow the selection of either 4,6 or 8 cynlinder vehicles
                                checkboxGroupInput('cyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
                                
                                # Creates a slider input that allows for a minumum of 50 and a max of 340 horsepower
                                sliderInput('hp', 'Horsepower', min=50, max=340, value=c(50,340), step=10),
                                
                                # Creates a slider input that allows for a minimum displacement of 70 and max of 480. It increments by 10
                                sliderInput('disp', 'Displacement', min=70, max=480, value=c(70,480), step=10)
                                
                                
                              ),
                              
                              
                              mainPanel(
                                dataTableOutput('table')
                              )
                            )
                   ),
                   tabPanel("How To",
                            mainPanel(
                              includeMarkdown("HowTo.md")
                            )
                   )
)
)   
