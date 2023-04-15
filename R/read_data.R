# prep
library(data.table)
dt_firms <- fread("data/DataFest2023/firmen.csv", nrows = 1000, na.strings=c('\"\"',"","NA"))
dt_persons <- fread("data/DataFest2023/personen.csv", nrows = 1000, na.strings=c('\"\"',"","NA"))
dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv", nrows = 1000, na.strings=c('\"\"',"","NA"))

#cleaning dt_firms
regex_umsatz <- "(?<=>\"\").*?(?=\"\")"

dt_firms <- dt_firms[ , "umsatz_help" := lapply(.SD, function(x) {regmatches(x, gregexpr(regex, x, perl = TRUE))}), 
                                           .SDcols = c("umsatz_staffel")]
dt_firms <- dt_firms[ , "umsatz" := lapply(.SD, function(y) unlist(lapply(y, function(x) x[1]))), 
                      .SDcols = c("umsatz_help")]

dt_firms <- dt_firms[ , "mitarbeiter_help" := lapply(.SD, function(x) {regmatches(x, gregexpr(regex, x, perl = TRUE))}), 
                      .SDcols = c("mitarbeiter_staffel")]
dt_firms <- dt_firms[ , "mitarbeiter" := lapply(.SD, function(y) unlist(lapply(y, function(x) x[1]))), 
                      .SDcols = c("mitarbeiter_help")]
dt_firms[, c("umsatz_help", "mitarbeiter_help", "umsatz_staffel", "mitarbeiter_staffel", "hr_nummer_info") := NULL]
#dt_firms[, lapply(.SD, function(x) replace(x, which(x=="NANA"), NA))]

#factoring
fac_cols <- c("umsatz", "mitarbeiter", "status", "rechtsform")
dt_firms[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]
dt_firms[ , lapply(.SD, str), .SDcols = fac_cols]

#cleaning dt_persons
fac_cols <- c("geschlecht", "jahr")
dt_persons[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]