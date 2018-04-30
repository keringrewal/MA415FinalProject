#install.packages(c("httr", "jsonlite"))

library(tidyverse)
library(dplyr)
library(tidytext)
library(ggplot2)
library(wordcloud)

#boston weather and flight data for 04/25/18
BOS_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/BOS/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
BOS_status <- GET(BOS_status_url)

#clevland, ohio flight data for 04/25/18
CLE_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/CLE/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
CLE_status <- GET(CLE_status_url)

#miami, florida flight data for 04/25/18
MIA_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/MIA/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
MIA_status <- GET(MIA_status_url)

#portland, oregon
PDX_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/PDX/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
PDX_status <- GET(PDX_status_url)

#san francisco, CA
SFO_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/SFO/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
SFO_status <- GET(SFO_status_url)

#dallas, TX
DFW_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/DFW/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
DFW_status <- GET(DFW_status_url)

BOS_content <- content(BOS_status)

BOS_content[["flightTracks"]][[1]] <- append(BOS_content[["flightTracks"]][[1]], list("tailNumber" = "None"), 3)

BOS_tracks <- BOS_content[["flightTracks"]]

BOS_tracks2 <- lapply(BOS_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

BOS_tracks3 <- do.call(rbind, BOS_tracks2)

BOS_tracks4 <- as.tibble(BOS_tracks3)

BOS_delay <- sum(as.numeric(BOS_tracks4$delayMinutes))

BOS_delay <- BOS_delay/nrow(BOS_tracks4)



CLE_content <- content(CLE_status)

CLE_tracks <- CLE_content[["flightTracks"]]

CLE_tracks2 <- lapply(CLE_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

CLE_tracks3 <- do.call(rbind, CLE_tracks2)

CLE_tracks4 <- as.tibble(CLE_tracks3)

CLE_delay <- sum(as.numeric(CLE_tracks4$delayMinutes))

CLE_delay <- CLE_delay/nrow(CLE_tracks4)



MIA_content <- content(MIA_status)

MIA_tracks <- MIA_content[["flightTracks"]]

MIA_tracks2 <- lapply(MIA_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

MIA_tracks3 <- do.call(rbind, MIA_tracks2)

MIA_tracks4 <- as.tibble(MIA_tracks3)

MIA_tracks4 <- MIA_tracks4[-47, ]

MIA_delay <- sum(as.numeric(MIA_tracks4$delayMinutes))

MIA_delay <- MIA_delay/nrow(MIA_tracks4)


PDX_content <- content(PDX_status)

PDX_tracks <- PDX_content[["flightTracks"]]

PDX_tracks2 <- lapply(PDX_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

PDX_tracks3 <- do.call(rbind, PDX_tracks2)

PDX_tracks4 <- as.tibble(PDX_tracks3)

PDX_delay <- sum(as.numeric(PDX_tracks4$delayMinutes))

PDX_delay <- PDX_delay/nrow(PDX_tracks4)


SFO_content <- content(SFO_status)

SFO_tracks <- SFO_content[["flightTracks"]]

SFO_tracks2 <- lapply(SFO_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

SFO_tracks3 <- do.call(rbind, SFO_tracks2)

SFO_tracks4 <- as.tibble(SFO_tracks3)

SFO_delay <- sum(as.numeric(SFO_tracks4$delayMinutes))

SFO_delay <- SFO_delay/nrow(SFO_tracks4)


DFW_content <- content(DFW_status)

DFW_content[["flightTracks"]][[1]] <- append(DFW_content[["flightTracks"]][[1]], list("delayMinutes" = 0), 8)

DFW_tracks <- DFW_content[["flightTracks"]]

DFW_tracks2 <- lapply(DFW_tracks, function(v) {c(v, rep(NA, 12-length(v)))})

DFW_tracks3 <- do.call(rbind, DFW_tracks2)

DFW_tracks4 <- as.tibble(DFW_tracks3)

DFW_tracks4 <- DFW_tracks4[-97, ]

DFW_delay <- sum(as.numeric(DFW_tracks4$delayMinutes))

DFW_delay <- DFW_delay/nrow(DFW_tracks4)
















#kmeans clustering shows what data is similar
BOS_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/BOS?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

BOS_weather <- GET(BOS_weather_url)

BOS_weather <- content(BOS_weather)

CLE_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/CLE?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

CLE_weather <- GET(CLE_weather_url)

CLE_weather <- content(CLE_weather)

DFW_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/DFW?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

DFW_weather <- GET(DFW_weather_url)

DFW_weather <- content(DFW_weather)

MIA_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/MIA?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

MIA_weather <- GET(MIA_weather_url)

MIA_weather <- content(MIA_weather)

PDX_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/PDX?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

PDX_weather <- GET(PDX_weather_url)

PDX_weather <- content(PDX_weather)

SFO_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/SFO?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

SFO_weather <- GET(SFO_weather_url)

SFO_weather <- content(SFO_weather)


#WEATHER ANALYSIS


BOS_forecast <- BOS_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]

BOS_forecast <- gsub('[[:punct:] ]+',' ', BOS_forecast)
BOS_forecast <- tolower(BOS_forecast)

BOS_forecast <- strsplit(BOS_forecast, " ")
BOS_forecast2 <- as.data.frame(BOS_forecast, col.names = "word")
data(stop_words)

BOS_forecast3 <- BOS_forecast2 %>% anti_join(stop_words) 
BOS_forecast3$city <- "BOS"

CLE_forecast <- CLE_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
CLE_forecast <- gsub('[[:punct:] ]+',' ', CLE_forecast)
CLE_forecast <- tolower(CLE_forecast)

CLE_forecast <- strsplit(CLE_forecast, " ")
CLE_forecast2 <- as.data.frame(CLE_forecast, col.names = "word")


CLE_forecast3 <- CLE_forecast2 %>% anti_join(stop_words) 
CLE_forecast3$city <- "CLE"


DFW_forecast <- DFW_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
DFW_forecast <- gsub('[[:punct:] ]+',' ', DFW_forecast)
DFW_forecast <- tolower(DFW_forecast)

DFW_forecast <- strsplit(DFW_forecast, " ")
DFW_forecast2 <- as.data.frame(DFW_forecast, col.names = "word")


DFW_forecast3 <- DFW_forecast2 %>% anti_join(stop_words) 
DFW_forecast3$city <- "DFW"


MIA_forecast <- MIA_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
MIA_forecast <- gsub('[[:punct:] ]+',' ', MIA_forecast)
MIA_forecast <- tolower(MIA_forecast)

MIA_forecast <- strsplit(MIA_forecast, " ")
MIA_forecast2 <- as.data.frame(MIA_forecast, col.names = "word")


MIA_forecast3 <- MIA_forecast2 %>% anti_join(stop_words) 
MIA_forecast3$city <- "MIA"


PDX_forecast <- PDX_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
PDX_forecast <- gsub('[[:punct:] ]+',' ', PDX_forecast)
PDX_forecast <- tolower(PDX_forecast)

PDX_forecast <- strsplit(PDX_forecast, " ")
PDX_forecast2 <- as.data.frame(PDX_forecast, col.names = "word")


PDX_forecast3 <- PDX_forecast2 %>% anti_join(stop_words) 
PDX_forecast3$city <- "PDX"


SFO_forecast <- SFO_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
SFO_forecast <- gsub('[[:punct:] ]+',' ', SFO_forecast)
SFO_forecast <- tolower(SFO_forecast)

SFO_forecast <- strsplit(SFO_forecast, " ")
SFO_forecast2 <- as.data.frame(SFO_forecast, col.names = 'word')


SFO_forecast3 <- SFO_forecast2 %>% anti_join(stop_words) 
SFO_forecast3$city <- "SFO"

good <- c("sun", "sunny", "80s", "80", "warm", "hot", "clear", "light", "60s", "5", "10", "15")

bad <- c("20", "30", "50s", "60s", "rain", "fog", "patchy", "cloudy", "thunderstorm", "thunderstorms", "cooler")

weather_words <- unique(Reduce(function(x, y) merge(x, y, all=TRUE), list(BOS_forecast3, CLE_forecast3, DFW_forecast3, MIA_forecast3, PDX_forecast3, SFO_forecast3)))

good_weather <- weather_words %>% filter(word %in% good)

bad_weather <- weather_words %>% filter(word %in% bad)

good <- count(good_weather, city)
names(good) <- c("city", "good")
bad <- count(bad_weather, city)
names(bad) <- c("city", "bad")

de <- data.frame(c("MIA", "PDX"), c(0, 0))
names(de) <- c("city", "bad")

bad <- rbind(bad, de)

ggplot(good, aes(x = city, y = good, color = city)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(0, 6)

ggplot(bad, aes(x = city, y = bad, color = city)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(0, 6)

analysis <- merge(good, bad)
ggplot(analysis, aes(x = city, y = (good-bad), color = city)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(-6, 6) +
  ylab("weather")




  
  
  