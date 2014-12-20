# This is the user-interface definition of a Shiny web application.

library(shiny);
shinyUI(fluidPage(
  # Application title
  headerPanel("Website User Analysis"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        helpText(HTML("<h5>Analyze the 2012-2014 User login data from CFBLNet CPT web application.</h5>")), hr(),
        selectInput("which", HTML("(<b>STEP 1</b>) Choose Feature to Analyze:"), choices = c("Login", "Browser", "Platform")), hr(),
        sliderInput("bins",  HTML("(<b>STEP 2</b>) Adjust Number of Bins to Use:"), min=1, max=50, value=6), hr(),
        dateRangeInput("dateRng", HTML("(<b>STEP 3</b>) Adjust Date Range:"), start="2014-06-01", min="2011-01-01", max="2015-01-01"),
        width=5
    ),

    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("distPlot"), hr(),
        h3(textOutput("Data")),
        tableOutput("table"),
        width=7
    ),

    position="right",
    fluid=TRUE
  )
))