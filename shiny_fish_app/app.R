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

my_theme <- bs_theme(
    bg = "red",
    fg = "blue",
    primary = "black",
    base_font = font_google("Times")
)

ui <- fluidPage(theme = my_theme,
                titlePanel("Dope Fish Data"),
                sidebarLayout(
                    sidebarPanel(
                        sliderInput("bins",
                                    "Number of bins:",
                                    min = 1,
                                    max = 50,
                                    value = 30)
                    ),

                    # Show a plot of the generated distribution
                    mainPanel(
                        plotOutput("distPlot")
                    )
                )

)
