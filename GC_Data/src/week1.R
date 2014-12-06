# csv ---------------------------------------------------------------------

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv", method="auto")list.files("./data")
dateDownloaded <- date()
dateDownloaded
cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData ,3)


# xlsx --------------------------------------------------------------------

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx", method="auto")
dateDownloaded <- date()
library(xlsx)
list.files()
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset

# XML ---------------------------------------------------------------------

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
doc
rootNode <- xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[3]]
names(rootNode[[2]])
xmlSApply(rootNode, xmlValue)

# /node Top level node; //node Node at any levels 
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
xpathSApply(rootNode, "//description", xmlValue)
xpathSApply(rootNode, "//calories", xmlValue)

## Reading 
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"

doc <- htmlTreeParse(fileUrl, useInternal=TRUE)

scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
sort(scores)
sort(teams)


# json --------------------------------------------------------------------
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$site_admin
myjson <- toJSON(iris, pretty=TRUE)
head(iris)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)
head(jsonData)
 
