library(shiny)
library(foreign)
library(ggplot2)
library(dplyr)
nom<-read.dta("nomData.DTA")
nom<-subset(nom, cong >=37)
nom$party[nom$party != 100 & nom$party != 200]<-300
nomSen<-read.dta("nomDataS.DTA")
nomSen<-subset(nomSen, cong>=37)
nomSen$party[nomSen$party != 100 & nomSen$party != 200]<-300


shinyUI(fluidPage(
  titlePanel("Preferences in the U.S. Congress"),

sidebarLayout(
  sidebarPanel(
    helpText("How has the distribution of legislators' preferences in the U.S. Congress changed since the Civil War?  Have the parties become more polarized?  Drag the slider below to find out!"),
     sliderInput("cong", 
                label = "Congress Number:", min = 37, max = 113, value = 1),
    p("Legislator preferences are measured using DW-NOMINATE.  DW-NOMINATE uses item response theory to scale legislators' voting records.  The estimated 'ideal points' range
    from -1 to 1, with lower values indicating liberal legislators, and higher values indicating more conservative legislators.  To make estimates
    comparable across time, legislators who served in multiple Congresses used to 'bridge.'  Lots more information, as well
    as the scores themselves, are available at", a(href = "http://www.voteview.com/", "Voteview."))
  ),
  mainPanel(
    textOutput("text1"),
    h3("House of Representatives"),
    plotOutput("density"),
    h3("Senate"),
    plotOutput("density2")
    )
  )
))
