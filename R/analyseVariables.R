# Variablen

# * mitarbeiter_staffel
# * umsatz_staffel
# * rechtsform TODO: filtern nach AG GmbH
# * wz_code (branche) TODO: filtern nach sinnvollem
# * gemeinde (david)
# * gewerbesteuer (david)
# * kapital
vars <- c("mitarbeiter", "umsatz", "rechtsform", "wz_code", "gem_key", "Gewerbesteuer", "kapital")


library(ggcorrplot)
model.matrix(~0+., data=dt_firms[, c("mitarbeiter", "umsatz")]) %>% 
  cor(use="pairwise.complete.obs") %>% 
  ggcorrplot(show.diag=FALSE, type="lower", lab=TRUE, lab_size=2)

table(dt_firms$umsatz, dt_firms$mitarbeiter)
plot(table(dt_firms$umsatz, dt_firms$mitarbeiter))

heatmap(table(dt_firms$umsatz, dt_firms$rechtsform))
