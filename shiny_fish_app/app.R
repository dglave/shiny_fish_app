#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)
library(palmerpenguins)
library(tidyverse)

fish <- read_csv("fish2.csv")

my_theme <- bs_theme(
    bg = "red",
    fg = "blue",
    primary = "black",
    base_font = font_google("Times")
)



# Creating the user interface
ui <- fluidPage(theme = my_theme,
    titlePanel("Grace and Dylan luv fi$h!"), # This is the title!
    sidebarLayout( # Adding a sidebar & main panel
        sidebarPanel("put my widgets here",
                     radioButtons(inputId = "fishing_entity_name",
                                  label = "Choose Entity Name (country)",
                                  choices = c("Brazil","Japan","Venezuela!" = "Venezuela") # This is my first widget for penguins species
                     ),
                     selectInput(inputId = "pt_color",
                                 label = "Select point color",
                                 choices = c("Awesome red!" = "red", "Pretty purple" = "purple", "ORAAANGE" = "orange")),
                     checkboxInput(inputId = "catch_status_name",
                                   label = "Is catch discard?",
                                   value = FALSE)
        ),

        mainPanel("Fishing entity (country) catch sum by year", # Adding things to the main panel
                  plotOutput(outputId = "fish_plot"),
                  checkboxInput("checkbox", label = "Choice A", value = TRUE),

                  hr(),
                  fluidRow(column(3, verbatimTextOutput("value")))

        )
    )
)

# Building the server:
server <- function(input, output) {

    fish_select <- reactive({
        fish %>%
            filter(fishing_entity_name == input$fishing_entity_name)
    })

    # Create a reactive plot, which depends on 'species' widget selection:

    output$fish_plot <- renderPlot({

        ggplot(data = fish_select(), aes(x = year, y = catch_sum)) +
            geom_point(color = input$pt_color, size = 5)

    })

    output$value <- renderPrint({input$checkbox})

}
shinyApp(ui = ui, server = server)
