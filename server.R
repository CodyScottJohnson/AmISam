#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(reticulate)

#py_install('face_recognition')
#system('pip install face_recognition')
face<- import('face_recognition')
np<- import('numpy')
pil <-import('PIL')
# Define server logic required to draw a histogram
#setwd("/srv/shiny-server/AmISam")
function(input, output, session) {
  show(id = "loading-content")  
  myCamera <- callModule(shinyviewr,"myCamera", outputWidth = 510, outputHeight = 510)
  # myCamera <- callModule(shinyviewr,"myCamera")
  hide(id = "loading-content", anim = TRUE, animType = "fade") 
  #logic for what happens after a user has drawn their values. Note this will fire on editing again too.
  observeEvent(myCamera(), {
    show(id = "loading-content")    
    print(dim(myCamera()))
    rastered_photo <- as.raster(myCamera())
    #save.image(rastered_photo,"unknown.png")
    #new_photo <- np$array(rastered_photo)
    #Test<-plot(rastered_photo, main = 'My Photo!')
    #outfile <- 'Images/notsam.png'
    outfile <- '/srv/shiny-server/AmISam/Images/notsam.png'
    png(file=outfile,
        width     = 500,
        height    = 500,
        units     = "px"
        )
    par(mar=c(0,0,0,0))
    plot(rastered_photo)
    graphics.off()
    amI <-py_run_file("AmISam.py", local = FALSE, convert = TRUE)
    Iam <-py_run_file("SamMarkup.py", local = FALSE, convert = TRUE)
    output$description <-renderText(Iam['points'])
    output$img_notsam <- renderImage({ list(src = "www/notsam_marked.png", height = 200, width = 200)}, deleteFile = FALSE)
    if(length(amI['results'])>= 2 & amI['results'][2]=="TRUE"){
      #output$results <-renderText("I'm Sorry Professor Mishra, but you are also not Sam")
    }
    else if(length(amI['results'])>= 1 & amI['results'][1]=="FALSE"){
      output$results <-renderText("Your Not Sam")
    } 
    else if(length(amI['results'])>= 1 & amI['results'][1]=="TRUE"){
      output$results <-renderText("You Did It, You Are Sam, Congratulations!")
    }
    
    
    output$snapshot <- renderPlot({plot(rastered_photo, main = 'My Photo!')})
    output$snapshot2<- renderPlot({plot(rastered_photo, main = 'My Photo!')})
    hide(id = "loading-content", anim = TRUE, animType = "fade") 
  })
}