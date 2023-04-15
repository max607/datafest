# prep
library(data.table)
dt_firms <- fread("data/DataFest2023/firmen.csv", nrows = 1000)
dt_persons <- fread("data/DataFest2023/personen.csv", nrows = 1000)
dt_persons_firms <- fread("data/DataFest2023/relationen_person_firma.csv", nrows = 1000)

# letter box
# number of employes
# too many companies in one specific point

