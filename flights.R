library(tidyverse)
library(dplyr)
library(tidytext)
library(ggplot2)
library(ggmap)

#DO NOT RUN THIS !!!!!

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


#END DO NOT RUN




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


#WEATHER ANALYSIS


BOS_forecast <- BOS_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]

BOS_forecast <- gsub('[[:punct:] ]+',' ', BOS_forecast)
BOS_forecast <- tolower(BOS_forecast)

BOS_forecast <- strsplit(BOS_forecast, " ")
BOS_forecast2 <- as.data.frame(BOS_forecast, col.names = "word")
data(stop_words)

BOS_forecast3 <- BOS_forecast2 %>% anti_join(stop_words) 
BOS_forecast3$city <- "BOS"

bos_forecast <- BOS_weather[["zoneForecast"]][["dayForecasts"]]
bos_forecast2 <- do.call(rbind, bos_forecast)
bos_forecast2 <- as.tibble(bos_forecast2)
bos_forecast3 <- bos_forecast2$forecast
bos_forecast4 <- gsub('[[:punct:] ]+',' ', bos_forecast3)
bos_forecast4 <- tolower(bos_forecast4)
bos_forecast5 <- as.tibble(bos_forecast4)
names(bos_forecast5) <- "word"
bos_forecast5$city <- "BOS"
bos_forecast5
bos_forecast6 <- strsplit(bos_forecast5$word, " ")

bos_forecast7 <- data.frame(word=unlist(bos_forecast6), city=rep(bos_forecast5$city, sapply(bos_forecast6, length)))
bos_forecast7 <- bos_forecast7 %>% anti_join(stop_words)

CLE_forecast <- CLE_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
CLE_forecast <- gsub('[[:punct:] ]+',' ', CLE_forecast)
CLE_forecast <- tolower(CLE_forecast)

CLE_forecast <- strsplit(CLE_forecast, " ")
CLE_forecast2 <- as.data.frame(CLE_forecast, col.names = "word")


CLE_forecast3 <- CLE_forecast2 %>% anti_join(stop_words) 
CLE_forecast3$city <- "CLE"

cle_forecast <- CLE_weather[["zoneForecast"]][["dayForecasts"]]
cle_forecast2 <- do.call(rbind, cle_forecast)
cle_forecast2 <- as.tibble(cle_forecast2)
cle_forecast3 <- cle_forecast2$forecast
cle_forecast4 <- gsub('[[:punct:] ]+',' ', cle_forecast3)
cle_forecast4 <- tolower(cle_forecast4)
cle_forecast5 <- as.tibble(cle_forecast4)
names(cle_forecast5) <- "word"
cle_forecast5$city <- "CLE"
cle_forecast5
cle_forecast6 <- strsplit(cle_forecast5$word, " ")

cle_forecast7 <- data.frame(word=unlist(cle_forecast6), city=rep(cle_forecast5$city, sapply(cle_forecast6, length)))
cle_forecast7 <- cle_forecast7 %>% anti_join(stop_words)



DFW_forecast <- DFW_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
DFW_forecast <- gsub('[[:punct:] ]+',' ', DFW_forecast)
DFW_forecast <- tolower(DFW_forecast)

DFW_forecast <- strsplit(DFW_forecast, " ")
DFW_forecast2 <- as.data.frame(DFW_forecast, col.names = "word")


DFW_forecast3 <- DFW_forecast2 %>% anti_join(stop_words) 
DFW_forecast3$city <- "DFW"

dfw_forecast <- DFW_weather[["zoneForecast"]][["dayForecasts"]]
dfw_forecast2 <- do.call(rbind, dfw_forecast)
dfw_forecast2 <- as.tibble(dfw_forecast2)
dfw_forecast3 <- dfw_forecast2$forecast
dfw_forecast4 <- gsub('[[:punct:] ]+',' ', dfw_forecast3)
dfw_forecast4 <- tolower(dfw_forecast4)
dfw_forecast5 <- as.tibble(dfw_forecast4)
names(dfw_forecast5) <- "word"
dfw_forecast5$city <- "DFW"
dfw_forecast5
dfw_forecast6 <- strsplit(dfw_forecast5$word, " ")

dfw_forecast7 <- data.frame(word=unlist(dfw_forecast6), city=rep(dfw_forecast5$city, sapply(dfw_forecast6, length)))
dfw_forecast7 <- dfw_forecast7 %>% anti_join(stop_words)



MIA_forecast <- MIA_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
MIA_forecast <- gsub('[[:punct:] ]+',' ', MIA_forecast)
MIA_forecast <- tolower(MIA_forecast)

MIA_forecast <- strsplit(MIA_forecast, " ")
MIA_forecast2 <- as.data.frame(MIA_forecast, col.names = "word")


MIA_forecast3 <- MIA_forecast2 %>% anti_join(stop_words) 
MIA_forecast3$city <- "MIA"

mia_forecast <- MIA_weather[["zoneForecast"]][["dayForecasts"]]
mia_forecast2 <- do.call(rbind, mia_forecast)
mia_forecast2 <- as.tibble(mia_forecast2)
mia_forecast3 <- mia_forecast2$forecast
mia_forecast4 <- gsub('[[:punct:] ]+',' ', mia_forecast3)
mia_forecast4 <- tolower(mia_forecast4)
mia_forecast5 <- as.tibble(mia_forecast4)
names(mia_forecast5) <- "word"
mia_forecast5$city <- "MIA"
mia_forecast5
mia_forecast6 <- strsplit(mia_forecast5$word, " ")

mia_forecast7 <- data.frame(word=unlist(mia_forecast6), city=rep(mia_forecast5$city, sapply(mia_forecast6, length)))
mia_forecast7 <- mia_forecast7 %>% anti_join(stop_words)




PDX_forecast <- PDX_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
PDX_forecast <- gsub('[[:punct:] ]+',' ', PDX_forecast)
PDX_forecast <- tolower(PDX_forecast)

PDX_forecast <- strsplit(PDX_forecast, " ")
PDX_forecast2 <- as.data.frame(PDX_forecast, col.names = "word")


PDX_forecast3 <- PDX_forecast2 %>% anti_join(stop_words) 
PDX_forecast3$city <- "PDX"

pdx_forecast <- PDX_weather[["zoneForecast"]][["dayForecasts"]]
pdx_forecast2 <- do.call(rbind, pdx_forecast)
pdx_forecast2 <- as.tibble(pdx_forecast2)
pdx_forecast3 <- pdx_forecast2$forecast
pdx_forecast4 <- gsub('[[:punct:] ]+',' ', pdx_forecast3)
pdx_forecast4 <- tolower(pdx_forecast4)
pdx_forecast5 <- as.tibble(pdx_forecast4)
names(pdx_forecast5) <- "word"
pdx_forecast5$city <- "PDX"
pdx_forecast5
pdx_forecast6 <- strsplit(pdx_forecast5$word, " ")

pdx_forecast7 <- data.frame(word=unlist(pdx_forecast6), city=rep(pdx_forecast5$city, sapply(pdx_forecast6, length)))
pdx_forecast7 <- pdx_forecast7 %>% anti_join(stop_words)



SFO_forecast <- SFO_weather[["zoneForecast"]][["dayForecasts"]][[1]][["forecast"]]
SFO_forecast <- gsub('[[:punct:] ]+',' ', SFO_forecast)
SFO_forecast <- tolower(SFO_forecast)

SFO_forecast <- strsplit(SFO_forecast, " ")
SFO_forecast2 <- as.data.frame(SFO_forecast, col.names = 'word')


SFO_forecast3 <- SFO_forecast2 %>% anti_join(stop_words) 
SFO_forecast3$city <- "SFO"

sfo_forecast <- SFO_weather[["zoneForecast"]][["dayForecasts"]]
sfo_forecast2 <- do.call(rbind, sfo_forecast)
sfo_forecast2 <- as.tibble(sfo_forecast2)
sfo_forecast3 <- sfo_forecast2$forecast
sfo_forecast4 <- gsub('[[:punct:] ]+',' ', sfo_forecast3)
sfo_forecast4 <- tolower(sfo_forecast4)
sfo_forecast5 <- as.tibble(sfo_forecast4)
names(sfo_forecast5) <- "word"
sfo_forecast5$city <- "SFO"
sfo_forecast5
sfo_forecast6 <- strsplit(sfo_forecast5$word, " ")

sfo_forecast7 <- data.frame(word=unlist(sfo_forecast6), city=rep(sfo_forecast5$city, sapply(sfo_forecast6, length)))
sfo_forecast7 <- sfo_forecast7 %>% anti_join(stop_words)




good <- c("sun", "sunny", "60s", "70s", "80s", "80", "warm", "hot", "clear", "light", "5", "10", "15", "steady", "upper", "80", "85")

bad <- c("20", "25", "30", "35", "30s", "40s", "50s", "rain", "fog", "patchy", "cloudy", "thunderstorm", "thunderstorms", "cooler", "100", "showers", "partly", "cool", "lower", "percipitation")

weather_words <- (Reduce(function(x, y) merge(x, y, all=TRUE), list(BOS_forecast3, CLE_forecast3, DFW_forecast3, MIA_forecast3, PDX_forecast3, SFO_forecast3)))

good_weather <- weather_words %>% filter(word %in% good)

bad_weather <- weather_words %>% filter(word %in% bad)

weekly_weather <- weather_words <- (Reduce(function(x, y) merge(x, y, all=TRUE), list(bos_forecast7, cle_forecast7, dfw_forecast7, mia_forecast7, pdx_forecast7, sfo_forecast7)))
#weekly_weather

good_week <- weekly_weather %>% filter(word %in% good)
#good_week
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


delay <- as.data.frame(c("BOS", "CLE", "DFW", "MIA", "PDX", "SFO"))
names(delay) <- "city"
delay$delay <- c(BOS_delay, CLE_delay, DFW_delay, MIA_delay, PDX_delay, SFO_delay)


ggplot(good2, aes(x = city, y = good, color = city)) + 
  geom_bar(stat="identity", fill="white") 

ggplot(bad2, aes(x = city, y = bad, color = city)) + 
  geom_bar(stat="identity", fill="white") 

analysis <- merge(good2, bad2)
ggplot(analysis, aes(x = city, y = (good-bad), color = city)) + 
  geom_bar(stat="identity", fill="white") + 
  ylab("weather") +
  ylim(-6, 6)

week_analysis <- merge(goodw, badw)
ggplot(week_analysis, aes(x = city, y = (good-bad), color = city)) + 
  geom_bar(stat="identity", fill="white") + 
  ylab("weather") +
  ylim(-25, 25)

delayAnalysis <- merge(analysis, delay)

ggplot(delayAnalysis, aes(x = city)) +
  geom_bar(aes(y = (good-bad), color = city), stat="identity", fill="white") +
  geom_point(aes(y = delay/50, color = city)) +
  ylab("weather condition and severity of delay") +
  labs(title = "Afternoon Weather Forecast and Delay Minutes") +
  ylim(-6, 6)


delay_week <- merge(week_analysis, delay)


ggplot(delay_week, aes(x = city)) +
  geom_bar(aes(y = (good-bad), color = city), stat="identity", fill="white") +
  geom_point(aes(y = delay/10, color = city)) +
  ylab("weather condition and severity of delay") +
  labs(title = "Week-Long Weather Forecast and Delay Minutes") +
  ylim(-25, 25)

map1 <- get_map(location = c(-95.7129, 37.0902), zoom = 3, maptype = "roadmap")

df <- data.frame(location = c('Boston Logan International Airport', 'Cleveland Hopkins International Airport', 'Dallas/Fort Worth International Airport', 'Miami International Airport', 'Portland International Airport', 'San Francisco International'), stringsAsFactors = FALSE)

geo_loc <- geocode(df$location)

df1 <- cbind(df, geo_loc)
names(df1) <- c('location', 'lon', 'lat')

ggmap(map1) + geom_point(data = df1, aes(x = lon, y = lat, color = location))


