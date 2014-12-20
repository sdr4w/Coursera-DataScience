library(RODBC);
library(sqldf);

ch <- odbcConnect("MySQL CFBLNet");
df <- sqlQuery(ch,"SELECT timestamp,userBrowser,userPlatform,actionType FROM _log WHERE actionSubType='LOGIN'");
df$timestamp <- as.character(df$timestamp);
odbcClose(ch);
write.table(df, file="userlogin.dat", append=FALSE);

df <- read.table(file="userlogin.dat");
levels(df$userBrowser)  <- c(levels(df$userBrowser), "Unknown");
levels(df$userPlatform) <- c(levels(df$userPlatform),"Unknown");
df$timestamp                         <- as.character(df$timestamp);
df$date                              <- as.Date(strsplit(df$timestamp," ")[[1]][1]);
df$time                              <- strsplit(df$timestamp," ")[[1]][2];
df$userBrowser[df$userBrowser==""]   <- "Unknown";
df$userPlatform[df$userPlatform==""] <- "Unknown";
