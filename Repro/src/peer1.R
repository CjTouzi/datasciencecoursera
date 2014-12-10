
# Load data ---------------------------------------------------------------

library(data.table)
act <- data.table(read.csv("./data/activity.csv"))
head(act)
tail(act)
names(act)

# What is mean total number of steps taken per day? -----------------------

# a histogram of the total number of steps taken each
stepsPerDay=act[,sum(steps, ra.rm=TRUE), by=date]
stepsPerDay$date <- as.Date(stepsPerDay$date, "%Y-%m-%d")
setnames(stepsPerDay,"V1", "totalSteps")
names(stepsPerDay)
library(ggplot2)
ggplot(stepsPerDay, aes(x=date, y=totalSteps)) +
        geom_bar(fill="orange", stat="identity") +
        labs(x="Date", y="Total Steps", title="Total Steps per Day")
mean(stepsPerDay$totalSteps, na.rm=TRUE)
median(stepsPerDay$totalSteps,na.rm=TRUE)

library(plyr)

# What is the average daily activity pattern? -----------------------------
stepsPerInterval <- ddply(act, .(interval), summarize, avgSteps=mean(steps, na.rm=TRUE))
plot(stepsPerInterval$avgSteps, type="l")
