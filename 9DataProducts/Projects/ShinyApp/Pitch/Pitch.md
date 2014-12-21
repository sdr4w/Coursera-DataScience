Pitch Presentation
========================================================
author: Steven Rankine
date:   21 December 2014


![](logo2.jpg) ![](logo2.jpg)

Overview
========================================================

Developed a User Analysis Shiny application that can be used to understand how and when users are connecting to a another website application. This feedback can be used to impact the following.

- Understand peak usage
- Identify cyclical and seasonal trends
- Understand who is accessing the web application
- Optimize Web Application for most users
- Potential for real-time updates and analysis

Link to application: http://sdr4w.shinyapps.io/ShinyApp/

Simple Interface
========================================================
The application is easy to use.  There are three steps.

- __STEP 1__: Select feature to analyze
- __STEP 2__: Select the number of category bins (optional)
- __STEP 3__: Select range of dates to analyze

A histogram of that feature will be automatcally generated for analysis.

Data Used to Feed Web Appication
========================================================

```
'data.frame':	4123 obs. of  3 variables:
 $ timestamp   : chr  "2012-02-06 10:06:35" "2012-02-06 11:43:02" "2012-02-06 12:06:55" "2012-02-06 12:10:02" ...
 $ userBrowser : Factor w/ 4 levels "Google Chrome",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ userPlatform: Factor w/ 3 levels "mac","Unknown",..: 2 2 2 2 2 2 2 2 2 2 ...
```

Example Histgram Produced
========================================================
This histogram shows usage over the last 6 months with a peak in the month of September.
<img src="Pitch-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />
