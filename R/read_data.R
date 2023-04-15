# Preparation --------------------------------------------------------------------------------------

dt_firms <- fread("data/DataFest2023/firmen.csv", nrows = 1000)
dt_persons <- fread("data/DataFest2023/personen.csv", nrows = 1000)
dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv", nrows = 1000)

# Exploration --------------------------------------------------------------------------------------

dt_firms[, firm_id] %>% unique() %>% length()
dt_persons[, pers_id] %>% unique() %>% length()
dt_persons_firms

