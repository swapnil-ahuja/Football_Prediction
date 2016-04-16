
shinyUI(fluidPage(
  titlePanel("Predicting Football using R"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Premier League"),
      
      selectInput("home_team", 
                  label = "Select Home Team",
                  choices = c("Arsenal"   ,     "Aston Villa" ,   "Burnley"     ,   "Chelsea"       , "Crystal Palace"
                              ,"Everton"    ,    "Hull"         ,  "Leicester"     , "Liverpool"      ,"Man City"      
                              ,"Man United"  ,   "Newcastle"     , "QPR"          ,  "Southampton"    ,"Stoke"         
                              ,"Sunderland"  ,   "Swansea"       , "Tottenham"     , "West Brom"      ,"West Ham"),
                  selected = "Arsenal"),
      
      selectInput("away_team", 
                  label = "Select Away Team",
                  choices = c("Arsenal"   ,     "Aston Villa" ,   "Burnley"     ,   "Chelsea"       , "Crystal Palace"
                              ,"Everton"    ,    "Hull"         ,  "Leicester"     , "Liverpool"      ,"Man City"      
                              ,"Man United"  ,   "Newcastle"     , "QPR"          ,  "Southampton"    ,"Stoke"         
                              ,"Sunderland"  ,   "Swansea"       , "Tottenham"     , "West Brom"      ,"West Ham"),
                  selected = "Aston Villa")
      
      
      ),
    
    mainPanel(
      textOutput("text1"),
      textOutput("text2"),
      plotOutput("newPlot")
      
    )
  )
))
