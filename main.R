# Packages -----------------------------------------------------------------------------------------

library(magrittr)
library(data.table)
library(ggplot2); theme_set(theme_bw())
library(mlr3)
library(mlr3cluster)
library(sf)
library(tmap)

# Scripts ------------------------------------------------------------------------------------------

source("R/read_data.R")
source("R/gewerbesteuer.R")
source("R/geospatial.R")
source("R/clustering.R")
source("R/plots-clustering")
