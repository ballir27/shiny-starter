#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define server logic required to draw a histogram
function(input, output, session) {
  
  filtered <- reactive({
    if (input$continent == "All Continents"){
      continent_filter <- continent_choices
    } else{
      continent_filter <- input$continent
    }

    gdp_le_2019 %>%
      filter(Continent %in% continent_filter)
  })
  
  output$scatterPlot <- renderPlot({
    filtered() %>% 
      ggplot(aes(x=GDP_Per_Capita, y = Life_Expectancy, color = Continent)) + geom_point()
  })
  
  # filtered <- reactive({
  #   if (input$island == "All Islands"){
  #     island_filter <- island_choices
  #   } else{
  #     island_filter <- input$island
  #   }
  #   
  #   penguins %>% 
  #     filter(island %in% island_filter)
  # })
  # 
  # output$distPlot <- renderPlot({
  #   
  #   filtered() %>% 
  #     drop_na(body_mass_g) %>% 
  #     ggplot(aes(x = body_mass_g)) +
  #     geom_histogram(bins = input$bins) +
  #     labs(title = "Histogram of Penguin Body Mass", x = "Body Mass of Penguins (grams)") +
  #     scale_x_continuous(limits = c(min(penguins$body_mass_g, na.rm = TRUE),
  #                                   max(penguins$body_mass_g, na.rm = TRUE)))
  #   
  # })
  #   
  #     # # generate bins based on input$bins from ui.R
  #     # x    <- faithful[, 2]
  #     # bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #     # 
  #     # # draw the histogram with the specified number of bins
  #     # hist(x, breaks = bins, col = 'darkgray', border = 'white',
  #     #      xlab = 'Waiting time to next eruption (in mins)',
  #     #      main = 'Histogram of waiting times')
  #   
  #   output$barPlot <- renderPlot({
  #     filtered() %>% 
  #       ggplot(aes(x=species)) + 
  #       geom_bar()
  #   
  # })

}
