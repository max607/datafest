# Preparation --------------------------------------------------------------------------------------

dt_firms <- fread("data/DataFest2023/firmen.csv", nrows = 1000, na.strings=c('\"\"',"","NA"))
dt_persons <- fread("data/DataFest2023/personen.csv", nrows = 1000, na.strings=c('\"\"',"","NA"))
dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv", nrows = 1000,
                          na.strings=c('\"\"',"","NA"))

# Exploration --------------------------------------------------------------------------------------

dt_all <- merge(dt_persons_firms, dt_firms, by = "firm_id", all = TRUE)
dt_all <- merge(dt_all, dt_persons, by = "pers_id", all = TRUE)

dt_firms[, ort] %>% table() %>% sort(decreasing = TRUE) %>% .[1:10]
dt_persons[, ort] %>% table() %>% sort(decreasing = TRUE) %>% .[1:10]

# wo wohnen Leute, deren Firma in Grünwald ist?
dt_all[ort.x == "Grünwald", table(ort.y)] %>% sort(decreasing = TRUE) %>% .[1:10]

dt_all[ort.x == "Grünwald" & ort.y == "Berlin", gegenstand][1:5]
dt_all[grepl("Siemens", firmenname), ]
dt_all[grepl("Maya", gegenstand), ]

dt_all[, .N, by = "firm_id"][order(N, decreasing = TRUE),][1:10,]

# Cleaning dt_firms --------------------------------------------------------------------------------
regex_umsatz <- "(?<=>\"\").*?(?=\"\")"

dt_firms[, "umsatz_help" := lapply(.SD, function(x) regmatches(x, gregexpr(regex, x, perl = TRUE))),
         .SDcols = c("umsatz_staffel")]
dt_firms[, "umsatz" := lapply(.SD, function(y) unlist(lapply(y, function(x) x[1]))),
         .SDcols = c("umsatz_help")]
dt_firms[, "mitarbeiter_help" := lapply(.SD, function(x) regmatches(x, gregexpr(regex, x, perl = TRUE))),
         .SDcols = c("mitarbeiter_staffel")]
dt_firms[, "mitarbeiter" := lapply(.SD, function(y) unlist(lapply(y, function(x) x[1]))),
         .SDcols = c("mitarbeiter_help")]
dt_firms[, c("umsatz_help", "mitarbeiter_help", "umsatz_staffel", "mitarbeiter_staffel",
             "hr_nummer_info") := NULL]
#dt_firms[, lapply(.SD, function(x) replace(x, which(x=="NANA"), NA))]

#factoring
fac_cols <- c("umsatz", "mitarbeiter", "status", "rechtsform")
dt_firms[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]

# Cleaning dt_persons ------------------------------------------------------------------------------
fac_cols <- c("geschlecht", "jahr")
dt_persons[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]
