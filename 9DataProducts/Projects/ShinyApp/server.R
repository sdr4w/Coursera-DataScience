# This is the server logic for a Shiny web application.

library(shiny);
library(sqldf);
library(ggplot2);

df <- read.table(file="userlogin.dat");
levels(df$userBrowser)  <- c(levels(df$userBrowser), "Unknown");
levels(df$userPlatform) <- c(levels(df$userPlatform),"Unknown");
df$timestamp                         <- as.character(df$timestamp);
df$date                              <- as.character(strsplit(df$timestamp," ")[[1]][1]);
df$time                              <- strsplit(df$timestamp," ")[[1]][2];
df$userBrowser[df$userBrowser==""]   <- "Unknown";
df$userPlatform[df$userPlatform==""] <- "Unknown";

shinyServer(function(input, output) {

  filter <- reactive({ df$timestamp >= input$dateRng[1] & df$timestamp <= input$dateRng[2] })
  output$title <- renderPrint({ paste("<center><b>",input$dateRng[1],"to",input$dateRng[2],"</b></center>",sep=" ") })
  output$table <- renderTable({
      tmp <- df[filter(), ];
      if(dim(tmp)[1] != 0){
          head(tmp[,2:6]);
      }
  })
  output$distPlot <- renderPlot({
      tmp   <- switch(input$which, "Login"=as.Date(df[filter(),1]), "Browser"=df[filter(),2],          "Platform"=df[filter(),3]);
      title <- switch(input$which, "Login"="Histogram of Logins",   "Browser"="Histogram of Browsers", "Platform"="Histogram of OS Platform");
      xname <- switch(input$which, "Login"="Timestamp",             "Browser"="Type of Browser Used",  "Platform"="Type of OS Platform");
      yname <- switch(input$which, "Login"="Number of Logins",      "Browser"="Percentage",            "Platform"="Percentage");
      fillc <- switch(input$which, "Login"="darkgray",              "Browser"="lightblue",             "Platform"="darkgray");
      sub   <- paste("From",input$dateRng[1],"to",input$dateRng[2],sep=" ");
      if( input$which == "Login" ) {
          bins <- seq(min(tmp), max(tmp), length.out=input$bins+1);
          hist(tmp, col=fillc, border='white', breaks=bins, main=title, sub=sub, xlab=xname, ylab=yname);
          box(col='red');
      } else {
          ggp <- ggplot(data.frame(tmp),aes(x=tmp)) + ggtitle(bquote(atop(.(title),atop(italic(.(sub)),"")))) + xlab(xname) + ylab(yname) + theme(panel.background=element_rect(colour="red"));
          ggp + geom_histogram(fill=fillc,aes(y=..count../sum(..count..)));
      }
  })

})

