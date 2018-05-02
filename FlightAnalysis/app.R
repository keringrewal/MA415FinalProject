library(shiny)
library(tidyverse)
library(dplyr)
library(tidytext)
library(ggplot2)
library(ggmap)
library(shinythemes)



#read in useful data
weather_words <- read.csv("afternoon_weather.csv")
weekly_weather <- read.csv("week_weather.csv")
delay <- read.csv("delay.csv")

good <- c("sun", "sunny", "60s", "70s", "80s", "80", "warm", "hot", "clear", "light", "5", "10", "15", "steady", "upper", "80", "85")

bad <- c("20", "25", "30", "35", "30s", "40s", "50s", "rain", "fog", "patchy", "cloudy", "thunderstorm", "thunderstorms", "cooler", "100", "showers", "partly", "cool", "lower", "percipitation")

good_weather <- weather_words %>% filter(word %in% good)

bad_weather <- weather_words %>% filter(word %in% bad)

good_week <- weekly_weather %>% filter(word %in% good)
bad_week <- weekly_weather %>% filter(word %in% bad)

good2 <- count(good_weather, city)
names(good2) <- c("city", "good")
bad2 <- count(bad_weather, city)
names(bad2) <- c("city", "bad")
de <- data.frame(c("MIA", "PDX"), c(0, 0))
names(de) <- c("city", "bad")
bad2 <- rbind(bad2, de)

goodw <- count(good_week, city)
names(goodw) <- c("city", "good")
badw <- count(bad_week, city)
names(badw) <- c("city", "bad")

afternoon_words <- merge(good2, bad2)
week_words <- merge(goodw, badw)


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("superhero"),
   
   # Application title
   titlePanel("Flight Delays and Weather"),
   
   # Sidebar with photos
   sidebarLayout(
     
     sidebarPanel(
       selectInput('comp', 'Choose Observation Time', 
                   choices = c('Afternoon' = '1', 'Week' = '2'),
                   selected = 'Afternoon'
       ),
       
       br(),
       img(src = "sunny-day.jpg", height = 250, width = 250),
       img(src = "rainy-day.jpg", height = 250, width = 250)
       
     ),
      # Show a plot of the generated distribution
      mainPanel(
        div(
          tabsetPanel(
            tabPanel("Graph", plotOutput("flightAnalysis", height = 500)),
            tabPanel("Table", tableOutput("table"))
          ), class = "span7"),
        
        br(),
        
        img(src = "white-plane-sky.jpg", width=700, height=425),
        
        br(),
        br(),
        br(),
        
        h3("Flight Delays and Cancellations"),
        h5("Tips and Tricks"),
        HTML('<iframe width="700" height="425" src="https://www.youtube.com/embed/0SBpOqzNgxM" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>'),
        
        br(),
        br(),
        br(),
        h3("My Conclusions Based on My Data"),
        p("The delay times in Boston, Cleveland, Dallas, and Portland show a coorelation to the weather. In San Francisco, there is a slight correlation. In Miami, there is no apparent coorelation. The long delays in Miami may have to do with some factor not related to weather, or conditions at other airports which lead to a backup in Miami."),
        br(),
        p("The limitations of my data was that the forecasts are relatively short, and that means there are not many words in each. Ranking the weather based on these words is therefore not completely accurate. Since the flight tracks only give you a 6 hour window, I did not have a lot of data to use for flight delays and this may have made the delay data inaccurate."),
        br(),
        p("I felt the timing was not ideal for this particular project, because in America in April there is very little severe weather, so the biggest hinderances will likely be rain and fog, whereas in January or February you may find more issues with snow, ice, and freezing temperatures."),
        br()
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  selectedData1 <- reactive({
    selected <- as.numeric(input$comp)
    
    if (selected == 1) {
      weather <- afternoon_words
    }
    else{
      weather <- week_words
    }
    
    weather
  })
  output$flightAnalysis <- renderPlot({
    weather <- selectedData1()
    delayAnalysis <- merge(weather, delay)
    
    ggplot(delayAnalysis, aes(x = city)) +
      geom_bar(aes(y = (good-bad), color = city), stat="identity", fill="white") +
      geom_point(aes(y = delay/10, color = city)) +
      ylab("weather condition and severity of delay") +
      labs(title = "Weather Forecast and Delay Minutes")
    
  })
  
  output$table <- renderTable(selectedData1())
  
}

# Run the application 
shinyApp(ui = ui, server = server)

