
# subsetting review -------------------------------------------------------

set.seed(13435)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10),"var3"=sample(11:15))
x 
x <- x[sample(1:5),]
x
x$var2[c(1,3)]=NA
x
x[,1]
x[,"var1"]
x[1:2,"var2"]

x[(x$var1<=3 & x$var3 >11),]
x[(x$var1 <=3 | x$var3>15)]

# dealing with missing value
x[which(x$var2>8),]

# sorting
sort(x$var1)
sort(x$var1, decreasing = TRUE)
sort(x$var2,na.last = TRUE)

# ordering 
x[order(x$var1),]
x[order(x$var1,x$var3),]


# ordering with plyr ------------------------------------------------------

library(plyr)
arrange(x,var1)
arrange(x,desc(var1))



# adding rows and cols ----------------------------------------------------

x$var4 <- rnorm(5)
x
Y <- cbind(x,rnorm(5))
Y
Y <- rbind(x,rnorm(5))
Y


# summarizing data --------------------------------------------------------
restData <- read.csv("./data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)

# check missing values 
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
colSums(is.na(restData))
all(colSums(is.na(restData)))

# values with specific characteristics

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]




#  cross tabs -------------------------------------------------------------

data(UCBAdmissions)
DF =as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~., data=warpbreaks)
xt
# flat tables 
ftable(xt)


# size of data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")


# create new varibles -----------------------------------------------------

# creating sequences

s1 <- seq(1,10, by=2);s1

s2 <- seq(1,10, length=3);s2
x <-c(1,3,8,25,100); seq(along=x)


# subsetting varibles 
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# creating binary variables
restData$zipWrong =ifelse(restData$zipCode<0,TRUE,FALSE)
table(restData$zipWrong, restData$zipCode<0)

# creating categorical variables

restData$zipGroups=cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

library(Hmisc)
restData$zipGroups=cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# creating factor variables

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
yesno <- sample(c("yes","no"), size=10, replace=TRUE)
yesno
yesnofac = factor(yesno,levels=c("yes","no"))
yesnofac
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)

# cutting produces factor variables

library(plyr)
restData2 =mutate(restData, zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)


# reshaping data ----------------------------------------------------------

# each variable forms a column

# each observatin forms a row

# each table/file stores data about one kind of observation 



# meling dataset
library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars = c("mpg","hp"))
head(carMelt)
tail(carMelt)

# casting datasframes


