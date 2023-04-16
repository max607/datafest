# Preparation --------------------------------------------------------------------------------------

dt_firms <- fread("data/DataFest2023/firmen.csv", nrows = Inf, na.strings=c('\"\"',"","NA"))
# dt_persons <- fread("data/DataFest2023/personen.csv", nrows = 5e4, na.strings=c('\"\"',"","NA"))
# dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv", nrows = 5e4,
                          # na.strings=c('\"\"',"","NA"))
# Cleaning dt_firms --------------------------------------------------------------------------------

regex_umsatz <- "(?<=>\"\").*?(?=\"\")"

dt_firms[, c("umsatz_help", "mitarbeiter_help") :=
         lapply(.SD, function(x) regmatches(x, gregexpr(regex_umsatz, x, perl = TRUE))),
         .SDcols = c("umsatz_staffel", "mitarbeiter_staffel")]
dt_firms[, c("umsatz", "mitarbeiter") :=
         lapply(.SD, function(y) unlist(lapply(y, function(x) x[1]))),
         .SDcols = c("umsatz_help", "mitarbeiter_help")]
dt_firms[, c("umsatz_help", "mitarbeiter_help", "umsatz_staffel", "mitarbeiter_staffel",
             "hr_nummer_info") := NULL]
#dt_firms[, lapply(.SD, function(x) replace(x, which(x=="NANA"), NA))]

fac_cols <- c("umsatz", "mitarbeiter", "status", "rechtsform")
dt_firms[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]

dt_firms <- na.omit(dt_firms, cols = c("ags24"))

# Cleaning dt_persons ------------------------------------------------------------------------------

# fac_cols <- c("geschlecht", "jahr")
# dt_persons[ , (fac_cols) := lapply(.SD, factor), .SDcols = fac_cols]

# Exploration --------------------------------------------------------------------------------------

# dt_all <- merge(dt_persons_firms, dt_firms, by = "firm_id", all = TRUE)
# dt_all <- merge(dt_all, dt_persons, by = "pers_id", all = TRUE)

# dt_firms[, ort] %>% table() %>% sort(decreasing = TRUE) %>% .[1:10]
# dt_persons[, ort] %>% table() %>% sort(decreasing = TRUE) %>% .[1:10]

# # wo wohnen Leute, deren Firma in Grünwald ist?
# dt_all[ort.x == "Grünwald", table(ort.y)] %>% sort(decreasing = TRUE) %>% .[1:10]

# dt_all[ort.x == "Grünwald" & ort.y == "Berlin", gegenstand][1:5]
# dt_all[grepl("Siemens", firmenname), ]
# dt_all[grepl("Maya", gegenstand), ]

# dt_all[, .N, by = "firm_id"][order(N, decreasing = TRUE),][1:10,]

# Neighbours ---------------------------------------------------------------------------------------

# dt_firms[ort == "Grünwald", length(unique(ags24)) / length(ags24)]
# dt_firms[ort == "München", length(unique(ags24)) / length(ags24)]
dt_firms <- merge(dt_firms, dt_firms[, .(neighbours = .N), by = ags24], by = "ags24")
# dt_firms[, .N, by = "neighbours"] %>%
#   .[, .(neighbours, N = N / neighbours)] %>%
#   .[order(neighbours, decreasing = TRUE),] %>%
#   .[neighbours < 300 & N < 1e3,] %>%
#   ggplot(aes(neighbours, N)) +
#   geom_point()

