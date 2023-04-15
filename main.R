# Packages -----------------------------------------------------------------------------------------

library(magrittr)
library(data.table)
library(ggplot2); theme_set(theme_bw())
library(mlr3)
library(mlr3cluster)

# Scripts ------------------------------------------------------------------------------------------

source("R/read_data.R")
source("R/gewerbesteuer.R")
source("R/description-external-data.R")  # geospacial data
source("R/clustering.R")
source("R/plots-clustering")

