#==============
# LOAD PACKAGES
#==============

library(rvest)
library(tidyverse)
library(ggmap)
library(stringr)

#==============
# GET WORLD MAP
#==============

map.europe <- map_data("world")
#=================================
# PLOT BASIC MAP
# - this map is "just the basics"
#=================================
map.europe%>%head()

#====================================================
# PLOT 'POLISHED' MAP
# - this version is formatted and cleaned up a little
#   just to make it look more aesthetically pleasing
#====================================================

#-------------
# CREATE THEME
#-------------
theme.maptheeme <-
  theme(text = element_text(family = "Gill Sans", color = "#444444")) +
  theme(plot.title = element_text(size = 32)) +
  theme(plot.subtitle = element_text(size = 16)) +
  theme(panel.grid = element_blank()) +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(legend.background = element_blank()) +
  theme(legend.key = element_blank()) +
  theme(legend.title = element_text(size = 18)) +
  theme(legend.text = element_text(size = 10)) +
  theme(panel.background = element_rect(fill = "#596673")) +
  theme(panel.grid = element_blank())
#------
# PLOT
#------


#New data
map.reusurbis= map.europe%>% 
  filter(region %in% c("Denmark","Spain","Portugal","UK","Italy"))

#===============================================================================
#Data for cities
library(ggmap)
#Data for cities
library(ggmap)
mydat <- read.csv(textConnection("
   cities,Freq,lon,lat
   Copenhagen,1.2,NA,NA
   Barcelona,3.25,NA,NA
   Lisbon,3.00,NA,NA
   Trentino,2.00,NA,NA
   South Wales,3.00,NA,NA"))

#Generate geodata
geocodes <- geocode(as.character(mydat$cities))

#Save geocodes 
setwd("C:/Users/vine/OneDrive - Danmarks Tekniske Universitet/Biowaste/Geodata")  
library(writexl)
write_xlsx(geocodes, "geocodes_resurbis_20180713.xlsx")
write.table(geocodes, file = "geocodes_resurbis_20180713.txt")
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mydat <- data.frame(mydat[,1:2],geocodes)
###Save this dataset
setwd("C:/Users/vine/OneDrive - Danmarks Tekniske Universitet/Biowaste/Geodata")  
library(writexl)
write_xlsx(mydat, "mydat_geocodes_resurbis_20180713.xlsx")
write.table(mydat, file = "mydat_geocodes_resurbis_20180713.txt")
#Combine data
#===============================================================================

geo_cities=read.table("C:/Users/vine/OneDrive - Danmarks Tekniske Universitet/Biowaste/Geodata/mydat_geocodes_resurbis_20180713.txt")
library(readxl)
Key_factors <- read_excel("C:/Users/vine/OneDrive - Danmarks Tekniske Universitet/Biowaste/Data_all_map/Key_factors.xlsx")
#+++++
Key_factors%>%head()
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#------
# PLOT2
#------
#fill = "#AAAAAA",colour = "#818181", size = .15)
library(scales)
ggplot() +
  geom_polygon(data = map.europe, aes(x = long, y = lat, group = group), 
               fill = "#DEDEDE",colour = "#818181", size = .15) +
  geom_polygon(data = map.reusurbis, aes(x = long, y = lat, group = group), 
               fill = "green3",colour = "green3", alpha = .3,size = .15) +
  geom_point(data = Key_factors, aes(x = lon, y = lat, size = Pop_Million), color = "red", alpha = .3) +
  #geom_point(data = df.euro_cities, aes(x = lon, y = lat, size = population), color = "red", shape = 1) +
  coord_cartesian(xlim = c(-9,38), ylim = c(37,70)) +
  #labs(title = "European Cities with Large Populations", subtitle = "Cities with over 1MM population, within city limits") +
  #scale_size_continuous(range = c(.7,15), breaks = c(1100000, 4000000, 8000000, 12000000), name = "Population", labels = scales::comma_format()) +
  theme.maptheeme

#df.euro_cities%>%View()
#df1=df.euro_cities%>% 
#  filter(city %in% c("Barcelona","London"))
#map.europe%>%head()
#map.europe%>%distinct(region,group)
#map.europe%>%distinct(region)%>%View()
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ggplot() +
  geom_polygon(data = map.europe, aes(x = long, y = lat, group = group), 
               fill = "#DEDEDE",colour = "#818181", size = .15) +
  geom_polygon(data = map.reusurbis, aes(x = long, y = lat, group = group), 
               fill = "green3",colour = "green3", alpha = .3,size = .15) +
  geom_point(data = Key_factors, aes(x = lon, y = lat, size = Pop_Million), size=4,color = "red", alpha = .3) +
  #geom_point(data = df.euro_cities, aes(x = lon, y = lat, size = population), color = "red", shape = 1) +
  coord_cartesian(xlim = c(-9,38), ylim = c(37,70)) +
  #labs(title = "European Cities with Large Populations", subtitle = "Cities with over 1MM population, within city limits") +
  #scale_size_continuous(range = c(.7,15), breaks = c(1100000, 4000000, 8000000, 12000000), name = "Population", labels = scales::comma_format()) +
  theme.maptheeme
