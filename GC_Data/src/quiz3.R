
# q1 ----------------------------------------------------------------------

fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/microSurvey2006.csv", method="auto")
micro <- read.csv("./data/microSurvey2006.csv")
head(micro)
names(micro)
agricultureLogical <- (micro$ACR == 3 & micro$AGS==6)
head(agricultureLogical)



# Q2 ----------------------------------------------------------------------
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="./data/q2.jpg", method="auto")
library(jpeg)
img <- readJPEG("data/q2.jpg", native=TRUE)
head(img)
quantile(img)
quantile(img, probs = c(0,0.3,0.8,1))



# Q3 ----------------------------------------------------------------------
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(fileUrl, destfile="./data/gdp.csv", method="auto")
fileUrl1="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile="./data/edu.csv", method="auto")

gdp <- read.csv("./data/gdp.csv", header = TRUE)
edu <- read.csv("./data/edu.csv", header = TRUE)
length(!is.na(intersect(gdp$X,edu$CountryCode)))
length(levels(gdp$X))

library(plyr)

which(arrange(gdp, desc(Gross.domestic.product.2012)),13)








