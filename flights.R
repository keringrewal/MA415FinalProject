#install.packages(c("httr", "jsonlite"))

library(tidyverse)
library(httr)
library(jsonlite)

#boston weather and flight data for 04/25/18
BOS_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/BOS/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
  
BOS_status <- GET(BOS_status_url)

BOS_content <- content(BOS_status)

BOS_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/BOS?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

BOS_weather <- GET(BOS_weather_url)

BOS_weather <- content(BOS_weather)

#clevland, ohio flight data for 04/25/18
CLE_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/CLE/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"

CLE_status <- GET(CLE_status_url)

CLE_content <- content(CLE_status)

CLE_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/CLE?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"
  
CLE_weather <- GET(CLE_weather_url)

CLE_weather <- content(CLE_weather)

#miami, florida flight data for 04/25/18
MIA_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/MIA/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
  
MIA_status <- GET(MIA_status_url)

MIA_content <- content(MIA_status)

MIA_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/MIA?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"
  
MIA_weather <- GET(MIA_weather_url)

MIA_weather <- content(MIA_weather)

#portland, oregon
PDX_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/PDX/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
PDX_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/PDX?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

PDX_status <- GET(PDX_status_url)

PDX_content <- content(PDX_status)

PDX_weather <- GET(PDX_weather_url)

PDX_weather <- content(PDX_weather)

#san francisco, CA
SFO_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/SFO/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
SFO_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/SFO?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

SFO_status <- GET(SFO_status_url)

SFO_content <- content(SFO_status)

SFO_weather <- GET(SFO_weather_url)

SFO_weather <- content(SFO_weather)

#dallas, TX
DFW_status_url <- "https://api.flightstats.com/flex/flightstatus/rest/v2/json/airport/tracks/DFW/dep?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580&includeFlightPlan=false"
DFW_weather_url <- "https://api.flightstats.com/flex/weather/rest/v1/json/all/DFW?appId=ce4ff307&appKey=4fea6501c301379a676e30e26cabc580"

DFW_status <- GET(DFW_status_url)

DFW_content <- content(DFW_status)

DFW_weather <- GET(DFW_weather_url)

DFW_weather <- content(DFW_weather)

#kmeans clustering shows what data is similar

