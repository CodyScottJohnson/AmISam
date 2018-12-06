
library(shinysense)
library(shinyjs)

shinyUI(fluidPage(
  useShinyjs(),
  withMathJax(),
  
  # Loading message
  hidden(div(
    id = "loading-content",
    HTML('<div class="app-loading">
      <div class="logo"></div>
         <svg class="spinner" viewBox="25 25 50 50">
         <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" />
         </svg>
         <img src="Loading.png"/>
           </div>')
  )),
                  tags$head(includeCSS("www/app.css")),
  
  navbarPage(
    img(src = 'sam-icon.png', align = "right"),
    tabPanel("Well Am I?",
             fluidRow(
               column(width = 12,id = "AmISam",
                      shinyviewrUI("myCamera", height = '510px')),
               column(width = 12,align="center",id="SamResults",
                      h2(textOutput("results"))
               )
             )),
    tabPanel("Why Aren't I Sam?",
             fluidRow(
               column(width = 6,align="center",class="notsam_col",
                      h2("You"),
                      imageOutput("img_notsam",height="200px"),
                      div(htmlOutput("description"))
               ),
               column(width = 6,align="center",
                      h2("Sam"),
                      img(
                        class = "img-face",
                        src = "sam_marked.png",
                        height="200px"
            
               ),
               div(HTML('<div class="tbl_con"><table class="face_features"><tr><th>Feature</th><th>Points</th></tr><tr><td class="feature">nose_bridge</td><td class="point">[(1190L, 459L), (1194L, 483L), (1198L, 506L), (1202L, 529L)]</td></tr><tr><td class="feature">left_eye</td><td class="point">[(1105L, 469L), (1119L, 462L), (1135L, 460L), (1151L, 467L), (1136L, 471L), (1119L, 473L)]</td></tr><tr><td class="feature">nose_tip</td><td class="point">[(1167L, 540L), (1183L, 542L), (1199L, 545L), (1214L, 541L), (1226L, 534L)]</td></tr><tr><td class="feature">chin</td><td class="point">[(1050L, 459L), (1056L, 495L), (1065L, 531L), (1074L, 565L), (1090L, 595L), (1111L, 620L), (1135L, 641L), (1163L, 652L), (1192L, 651L), (1218L, 640L), (1235L, 620L), (1249L, 596L), (1263L, 568L), (1273L, 539L), (1280L, 508L), (1281L, 478L), (1278L, 448L)]</td></tr><tr><td class="feature">right_eye</td><td class="point">[(1218L, 459L), (1231L, 450L), (1245L, 447L), (1256L, 450L), (1247L, 457L), (1233L, 459L)]</td></tr><tr><td class="feature">left_eyebrow</td><td class="point">[(1080L, 450L), (1094L, 432L), (1116L, 425L), (1139L, 427L), (1161L, 434L)]</td></tr><tr><td class="feature">bottom_lip</td><td class="point">[(1235L, 571L), (1221L, 582L), (1207L, 589L), (1193L, 593L), (1180L, 593L), (1158L, 590L), (1135L, 579L), (1143L, 579L), (1181L, 581L), (1193L, 580L), (1207L, 578L), (1227L, 573L)]</td></tr><tr><td class="feature">right_eyebrow</td><td class="point">[(1215L, 432L), (1229L, 421L), (1245L, 414L), (1260L, 414L), (1271L, 424L)]</td></tr><tr><td class="feature">top_lip</td><td class="point">[(1135L, 579L), (1159L, 572L), (1182L, 568L), (1194L, 570L), (1208L, 566L), (1221L, 567L), (1235L, 571L), (1227L, 573L), (1209L, 577L), (1195L, 580L), (1182L, 580L), (1143L, 579L)]</td></tr></table></div>'))
               )
             )),
    tabPanel("Tell Me About Sam",
             fluidRow(column(width = 12,align="center",
               div(class="about",includeMarkdown("about.md"))
             )
             ))
  )
))