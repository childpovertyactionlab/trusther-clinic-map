rm(list=ls(all=TRUE))
#setwd("C:/Users/OwenWilson-Chavez/CPAL Dropbox") #Owen Directory
#setwd("C:/Users/micha/CPAL Dropbox") #Michael Laptop Directory
setwd("E:/CPAL Dropbox") #Michael Desktop Directory

library(googlesheets4)
library(tidyverse)
library(sf)
library(tigris)
library(leaflet)

CPALmap <- "https://api.mapbox.com/styles/v1/owencpal/ckecb71jp22ct19qc1id28jku/tiles/256/%7Bz%7D/%7Bx%7D/%7By%7D@2x?access_token=pk.eyJ1Ijoib3dlbmNwYWwiLCJhIjoiY2tlYnR3emdxMGNhZzMwb2EzZWR4ajloNCJ9.P7Mujz8F3Rssq5-Q6dcvMw"

TrustHerClinic <- range_read("https://docs.google.com/spreadsheets/d/1QSeMpSoZRFPMW4l4P3k0LE_brDKARhGXrGgrkD83FsQ/edit#gid=472929183", sheet = "Clinic Sites Master") %>%
  st_as_sf(., coords = c("Longitude", "Latitude"), crs = 4326)
head(TrustHerClinic)
names(TrustHerClinic)

plot(TrustHerClinic$geometry)

options(viewr=NULL)
leaflet() %>%
  setView(lng = -96.7970, lat = 32.7767, zoom = 11) %>%
  addTiles(urlTemplate = CPALmap) #%>%
  addCircleMarkers(data = TrustHerClinic,
                   stroke = FALSE,
                   fillOpacity = 0.5,
                   fillColor = "#008097")

st_write(TrustHerClinic, "Trust Her/Data/GIS/TrustHer_ProjectFiles.gpkg", layer = "Clinic Locations")
