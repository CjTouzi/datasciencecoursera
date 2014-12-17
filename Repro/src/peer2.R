
# Health and Economic Impact of Weather Events in the US ------------------

storm <- read.csv(bzfile("./data/repdata-data-StormData.csv.bz2"))        
# names(storm)

event_type <- tolower(storm$EVTYPE)
length(unique(event_type))
translate all letters to lowercase

# replace all punct. characters with a space
event_type <- gsub("[[:blank:][:punct:]+]", "", event_type)
# data processing 
storm$EventTypeCode<- event_type
head(storm$EventTypeCode)
length(unique(event_type))

tolower(names(storm))
head(storm$MAG)

popHealthFactor<- c("fatalities","injuries")
EcoFactor <- c("prop_dmg, crop_dmg")

# Across the United States, 
# which types of events 
# (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?

library(plyr)
fatalCount <- ddply(storm, .(EventTypeCode), summarize, fatalities = sum(FATALITIES))
injurCount <- ddply(storm, .(EventTypeCode), summarize, injuries = sum(INJURIES))

as.POSIXct(strptime(storm$BGN_DATE[1:10], "%m/%d/%Y %H:%M:%S"))

fatalCount <- ddply(storm, .~EventTypeCode, summarize, fatalities = sum(FATALITIES))

fatalTop10 <- fatalCount[order(fatalCount$fatalities,decreasing = T)[1:10],] 
fatalTop10 
injurTop10 <- injurCount[order(injurCount$injuries,decreasing = T)[1:10],] 
injurTop10

# plot 

library(ggplot2)
library(gridExtra)

# Set the levels in order
p1 <- ggplot(data=fatalTop10,
             aes(x=reorder(EventTypeCode, fatalities ), y=fatalities , fill=fatalities)) +
        geom_bar(stat="identity") +
        coord_flip() +
        ylab("Total number of fatalities") +
        xlab("Event type") +
        theme(legend.position="none")

p2 <- ggplot(data=injurTop10,
             aes(x=reorder(EventTypeCode, injuries), y=injuries, fill=injuries)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        ylab("Total number of injuries") +
        xlab("Event type") +
        theme(legend.position="none")

grid.arrange(p1, p2, main="Top 10 harmful weather events for health in the US (1950-2011)")


# Economic Effects of Weather Events --------------------------------------

storm$PROPDMG[1:10]
storm$PROPDMGEXP[1:10]

levels(storm$PROPDMGEXP)



exp_transform <- function(e) {
        # h -> hundred, k -> thousand, m -> million, b -> billion   
        #switch(e,'h'=2,'H'=2,0)
        if (e %in% c('h', 'H')) return(2)
        if (e %in% c('k', 'K')) return(3)
        if (e %in% c('m', 'M')) return(6)
        if (e %in% c('b', 'B')) return(9)
        if ((as.numeric(e)) %in% seq(1:8)) return(as.numeric(e)) 
        if (e %in% c('', '-', '?', '+')) return(-1)
        return(-2)
        
}

propDmgExp <- sapply(storm$PROPDMGEXP, FUN=exp_transform)
propDmgDollar <- as.numeric(storm$PROPDMG * (10 ** propDmgExp))
rm(propDmgExp)
cropDmgExp <- sapply(storm$CROPDMGEXP, FUN=exp_transform)
cropDmgDollar<- as.numeric(storm$CROPDMG * (10 ** cropDmgExp))
rm(cropDmgExp)

EcoDmg<- data.frame(EventTypeCode=storm$EventTypeCode, propDmgDollar, cropDmgDollar)


PropDmgCost <- ddply(EcoDmg, .(EventTypeCode), summarize, propDmg = sum(propDmgDollar))
CropDmgCost <- ddply(EcoDmg, .(EventTypeCode), summarize, CropDmg = sum(cropDmgDollar))

PropDmgTop10 <- PropDmgCost[order(PropDmgCost$propDmg,decreasing = T)[1:10],] 
PropDmgTop10

CropDmgTop10 <- CropDmgCost[order(CropDmgCost$CropDmg,decreasing = T)[1:10],] 
CropDmgTop10$

# plot 

library(ggplot2)
library(gridExtra)

# Set the levels in order
p1 <- ggplot(data=PropDmgTop10,
             aes(x=reorder(EventTypeCode, propDmg), y=log10(propDmg), fill=propDmg)) +
        geom_bar(stat="identity") +
        coord_flip() +
        ylab("Property damage Dollar cost in log-scale (1950-2011) ") +
        xlab("Event type") +
        theme(legend.position="none")


p2 <- ggplot(data=CropDmgTop10,
             aes(x=reorder(EventTypeCode, CropDmg), y=log10(CropDmg), fill=CropDmg)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        ylab("Crop damage Dollar cost in log-scale (1950-2011)") +
        xlab("Event type") +
        theme(legend.position="none")

grid.arrange(p1, p2, main="Top 10 harmful weather events for Economic in the US (1950-2011)")




