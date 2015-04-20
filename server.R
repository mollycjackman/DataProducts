library(foreign)
library(ggplot2)
library(dplyr)
setwd("~/Dropbox/Programming/DataProducts/courseProject1")
nom<-read.dta("nomData.DTA")
nom<-subset(nom, cong >=37)
nom$party[nom$party != 100 & nom$party != 200]<-300
nomSen<-read.dta("nomDataS.DTA")
nomSen<-subset(nomSen, cong>=37)
nomSen$party[nomSen$party != 100 & nomSen$party != 200]<-300


shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({ 
      paste("Congress number:", input$cong)
    })
    
    
    dataset<- reactive({
      subset(nom, cong == input$cong)    
    })

    
    datasetSen<- reactive({
      subset(nomSen, cong == input$cong)  
    })

    
    output$density<- renderPlot({
      dataset<-dataset()
      if (nrow(dataset)<4) return()
      p<-ggplot(dataset, aes(x=dwnom1, fill=factor(party))) +
        geom_density(alpha=.5) +scale_fill_manual(values = c("blue","red", "green"), name = "Party", labels = c("Democrat", "Republicans", "Other"))+
        xlab("DW-NOMINATE Ideal Point")
      print(p)
    })
    
    output$density2<- renderPlot({
      datasetSen<-datasetSen()
      if (nrow(datasetSen)<4) return()
      p<-ggplot(datasetSen, aes(x=dwnom1, fill=factor(party))) +
        geom_density(alpha=.5) +scale_fill_manual(values = c("blue","red", "green"), name = "Party", labels = c("Democrat", "Republicans", "Other"))+
        xlab("DW-NOMINATE Ideal Point")
      print(p)
    })
    
    }
)