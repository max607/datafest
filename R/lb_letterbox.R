str(dt_firms)

dt_firms_filter = dt_firms[!is.na(Gewerbesteuer) & !is.na(umsatz) & !is.na(kapital) &
			  rechtsform %in% c("GMBH", "GMBH_CO_KG", "AG", "LTD") &
			  mitarbeiter == "0-5" &
			  umsatz %in% c("25000-99999", "100000-999999", "GR_1000000")]
#			  c("Gewerbesteuer", "umsatz", "mitarbeiter", "kapital")]
# dt_firms_clust[, kapital := log(kapital)]

string <- dt_firms_filter$wz_code
string <- gsub('\\{', '', string)
string <- gsub('\\}', '', string)
wz_code = unlist(lapply(string, function(s) unlist(strsplit(s, ","))))

c("70", "70101")
c("Verwaltung und Führung von Unternehmen und Betrieben; Unternehmensberatung",
  "Managementtätigkeiten von Holdinggesellschaften")

string_all <- dt_firms$wz_code
string_all <- gsub('\\{', '', string_all)
string_all <- gsub('\\}', '', string_all)
wz_code_all = unlist(lapply(string_all, function(s) unlist(strsplit(s, ","))))

