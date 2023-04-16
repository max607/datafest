str(dt_firms)

dt_firms_filter = dt_firms[!is.na(Gewerbesteuer) & !is.na(umsatz) & !is.na(kapital) &
			  rechtsform %in% c("GMBH", "GMBH_CO_KG", "AG", "LTD") &
			  mitarbeiter == "0-5" &
			  umsatz %in% c("25000-99999", "100000-999999", "GR_1000000")]
#			  c("Gewerbesteuer", "umsatz", "mitarbeiter", "kapital")]
# dt_firms_clust[, kapital := log(kapital)]

c("70", "70101")
c("Verwaltung und Führung von Unternehmen und Betrieben; Unternehmensberatung",
  "Managementtätigkeiten von Holdinggesellschaften")
