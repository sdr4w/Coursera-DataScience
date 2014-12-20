# This is the user-interface definition of a Shiny web application.

library(shiny);

shinyUI(fluidPage(

  # Application title
#   titlePanel("Website User Login Data"),
  headerPanel("Website User Login Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
      selectInput("which", "Choose a dataset:", choices = c("Login", "Browser", "Platform")),
      hr(),
      dateRangeInput("dateRng","Date Range",start="2014-06-01",min="2011-01-01",max="2015-01-01"),
      helpText("Data from CFBLNet CPT website.")
    ),

    # Show a plot of the generated distribution
    mainPanel(
#         htmlOutput("title"),
#         hr(),
        plotOutput("distPlot"),
        tableOutput("table1"),
        plotOutput("pieChart")
    )
  )
))