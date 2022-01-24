# setup


library(stars)
library(layer)
library(viridis)
library(tidyverse)
library(sf)
library(tmap)
library(gridExtra)
library(ggpubr)
library(caret)
library(ranger)



sf::sf_use_s2(FALSE)

countries = rnaturalearth::countries110 %>% 
    st_as_sf() %>%
    st_union()






