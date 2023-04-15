# Preparation --------------------------------------------------------------------------------------

library(data.table)
dt_firms <- fread("data/DataFest2023/firmen.csv")
dt_persons <- fread("data/DataFest2023/personen.csv")
dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv")

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


