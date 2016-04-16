# server.R
library(ggplot2)
#setwd("~/Documents/R/Football")

for (i in 2010:2016){
  
  df <- read.csv(paste("Data//",i,".csv",sep=""))
  
  
  df <- apply(df,1,function(row){
    data.frame(
      team=c(row['HomeTeam'],row['AwayTeam']),
      opponent=c(row['AwayTeam'],row['HomeTeam']),
      goals=c(row['FTHG'],row['FTAG']),
      home=c(1,0)
    )
    
  })
  df <- do.call(rbind,df)
  
  if (i==1994){
    df_final<-df
  }
  else{
    df_final<-rbind(df_final,df)
  }
  
  
}

rownames(df_final)<-NULL # To Remove Unwanted Values


df_final$home <- as.factor(df_final$home)
df_final$goals <- as.character(df_final$goals)
df_final$goals <- as.numeric(df_final$goals)

model<-glm(goals ~ home + team + opponent, family=poisson(link=log), data=df_final)


shinyServer(
  function(input, output) {
    
    g1<-reactive({predict(model, data.frame(home=as.factor(1), team=input$home_team, opponent=input$away_team), type="response")})
    
    g2<-reactive({predict(model, data.frame(home=as.factor(0), team=input$away_team, opponent=input$home_team), type="response")})
    
    
    
    
    
    
    
    output$text1 <- renderText({ 
      
     
    })
    
    output$text2 <- renderText({ 
      
      
    })
    
    output$newPlot <- renderPlot({
      
      m <- dpois(0:7,g1()) %o% dpois(0:7,g2())
      rownames(m) <- 0:7
      colnames(m) <- 0:7
      draw <- sum(diag(m))*100
      away <- sum(m[upper.tri(m)])*100
      home <- sum(m[lower.tri(m)])*100
      
      
      data<-data.frame(Result=c(paste(input$home_team," (Home)-Win",sep=""),"Draw",paste(input$away_team," (Away)-Win",sep="")),perc=c(home,draw,away))
      
      data$perc<-round(data$perc,2)
      bp<- ggplot(data, aes(x="", y=perc, fill=Result))+geom_bar(width = 1, stat = "identity")
      pie <- bp + coord_polar("y", start=0)
      blank_theme <- theme_minimal()+
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.border = element_blank(),
          panel.grid=element_blank(),
          axis.ticks = element_blank(),
          axis.text.x=element_blank(),
          plot.title=element_text(size=14, face="bold"),
          legend.text=element_text(size=20),
          legend.title=element_text(size=24)
          
        )
      
      pie<-pie +blank_theme+ geom_text(aes(y = perc/3 + c(0, cumsum(perc)[-length(perc)]), 
                                      label = perc), size=6)
      
      print(pie)
    })
    
  }
)
