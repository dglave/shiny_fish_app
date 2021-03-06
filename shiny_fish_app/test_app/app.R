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
library(shinydashboard)
library(shinythemes)
library(hrbrthemes)

fish <- data.table::fread("fish2.csv")

my_theme <- bs_theme(
    bg = "red",
    fg = "blue",
    primary = "black",
    base_font = font_google("Times")
)


# icons below from: https://fontawesome.com/icons?d=gallery&q=world
# Creating the user interface
ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = "Grace & Dylan luv fish"),
                    dashboardSidebar(
                        sidebarMenu(id = "menu",
                                    menuItem("Fishermen",
                                             tabName = "fishermen_tab",
                                             icon = icon("fas fa-anchor")),
                                    menuItem("Home",
                                             tabname = "home_tab",
                                             icon = icon("fas fa-globe")),
                                    menuItem("Fish",
                                             tabName = "fish_graph_tab",
                                             icon = icon("fish")))),

                    dashboardBody(
                        # fluidPage(theme = my_theme,
                                  # h1("Really important things about fish here"), #header on all tabs
                                  # p("Fish tend to have two eyes", #subheader on all tabs
                                  #   a("What IS a fish exactly?", #subheader on all tabs
                                  #     href = "https://en.wikipedia.org/wiki/Fish")#end of a
                                  #   )#end of p
                                  # ),#end of fluidPage
                        tabItems(
 # took this next tab from a different example - it's not showing up yet
                            tabItem(tabName = "fishermen_tab",
                                    h3("Fish or not a fish?"),
                                    p("Description blah blah text")#end of p
                            ),
                            tabItem(tabName = "home_tab",
                                    h3("I'm not showing up right now:"),
                                    p("This app will show blah blah blah")#end of p
                                     ),#end of tabItem1
                            #end of tabItem2
                            tabItem(tabName = "fish_graph_tab",
                                    fluidRow(
                                        shinydashboard::box(title = "Catch sum by entity graph",
                                                            selectInput("fishing_entity_name",
                                                                        label = h4("Choose entity name (country):"),
                                                                        choices = c(unique(fish$fishing_entity_name)#end of unique
                                                                                    ),#end of c
                                                                        selected = 1,
                                                                        multiple = FALSE

                                                                        ),#end of selectInput
                                                            hr(),
                                                            fluidRow(column(3, verbatimTextOutput("value"))# also added this hr section, not doing anything
                                                            )),#end of box
                                        shinydashboard::box(plotOutput(outputId = "fish_plot")#end of plotOutput (here is where i ended in script, and it works!)
                                                            )#end of box
                                    )#end of fluidRow
                                    )#end of tabItem3
                        )#end of tabItems


                    )#end of dashboardBody
                    )#end of dashboardPage


# -------------------------------------------------------------------------
# Build the server
server <- function(input, output) {


    fish_select <- reactive({
        fish %>%
            filter(fishing_entity_name == input$fishing_entity_name)#end of filter


    }#end of reactive({})
    )#end of reactive
# where end of first {} used to be before adding output section

# Create a reactive plot, which depends on 'species' widget selection:

output$fish_plot <- renderPlot({

  ggplot(data = fish_select(), aes(x = year, y = catch_sum)) +
    geom_point() #removed point color aspect

})

output$value <- renderPrint({ input$fishing_entity_name }) # this is the last thing I added
}



#### End of sort-of-working app






# ---------------------------------------------------------------------------
# Create a reactive plot (this section doesn't work right now)
# running this code causes an error and won't allow the app to run- is it because we don't have the radio buttons like on the earlier version?
# output$fish_plot <- renderPlot({
#
#     ggplot(data = fish_select(), aes(x = year, y = catch_sum)) +
#         geom_point(color = input$pt_color, size = 5)
#
# })

# ---------------------------------------------------------------------------

shinyApp(ui = ui, server = server)

# ---------------------------------------------------------------------------





