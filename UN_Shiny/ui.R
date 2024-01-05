#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("UN Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("continent",
      label = h3("Select a Continent"),
      choices = continent_choices,
      selected = continent_choices[1]),
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column(width = 12,
               plotOutput("scatterPlot")
        )
      )
    )
  )
) 
  