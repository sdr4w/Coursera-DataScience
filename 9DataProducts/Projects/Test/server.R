# This is the server logic for a Shiny web application.

library(shiny);
library(RODBC);
library(sqldf);
library(ggplot2);

ch <- odbcConnect("MySQL CFBLNet");
df <- sqlQuery(ch,"SELECT timestamp,userBrowser,userPlatform,actionType FROM _log WHERE actionSubType='LOGIN'");
odbcClose(ch);

shinyServer(function(input, output) {

  dataset <- reactive({ subset(df, timestamp >= input$dateBeg & timestamp <= input$dateEnd) })
  output$title  <- renderPrint({ paste("<center><b>",input$dateRng[1],"to",input$dateRng[2],"</b></center>",sep=" ") })
  output$table1 <- renderTable({
      tmp <- df[,1:3];
      tmp$timestamp <- as.character(tmp$timestamp);
      head(tmp);
  })
  output$distPlot <- renderPlot({
      tmp  <- switch(input$which, "Login" = df[,1],  "Browser" = df[,2], "Platform" = df[,3]);
      if( input$which == "Login" ) {
          bins <- seq(min(tmp), max(tmp), length.out=input$bins+1);  # generate bins based on input$bins from ui.R
          hist(tmp, breaks=bins, col='darkgray', border='white');    # draw the histogram with the specified number of bins
      } else if( input$which == "Browser" ) {
          ggp <- ggplot(data.frame(tmp),aes(x=tmp));
          ggp + geom_histogram(fill="lightblue",aes(y=..count../sum(..count..))) + ggtitle("Type of Browser Used") + xlab("Browser Type") + ylab("Percentage");
      } else {
          ggp <- ggplot(data.frame(tmp),aes(x=tmp));
          ggp + geom_histogram(fill="black",aes(y=..count../sum(..count..))) + ggtitle("Type of OS Platform") + xlab("Platform Type") + ylab("Percentage");
#            ggp <- ggplot(df, aes(x=factor(1), fill=factor(df$userBrowser))) + geom_bar(width = 1);
#            ggp + coord_polar(theta = "y");
      }
  }, width=600)

})

# library(shiny);
# library(ggplot2);
#
# shinyServer(function(input, output) {
#
#     dataset <- reactive( function() {
#         diamonds[sample(nrow(diamonds), input$sampleSize),]
#     })
#
#     output$plot <- reactivePlot(function() {
#
#         p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
#
#         if (input$color != 'None')
#             p <- p + aes_string(color=input$color)
#
#         facets <- paste(input$facet_row, '~', input$facet_col)
#         if (facets != '. ~ .')
#             p <- p + facet_grid(facets)
#
#         if (input$jitter)
#             p <- p + geom_jitter()
#         if (input$smooth)
#             p <- p + geom_smooth()
#
#         print(p)
#
#     }, height=700)
#
# })
