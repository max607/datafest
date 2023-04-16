str(dt_firms)

dt_firms_filter = dt_firms[!is.na(Gewerbesteuer) & !is.na(umsatz) & !is.na(kapital) &
			  rechtsform %in% c("GMBH", "GMBH_CO_KG", "AG", "LTD") &
			  mitarbeiter == "0-5" &
			  neighbours >= "100" &
			  umsatz %in% c("25000-99999", "100000-999999", "GR_1000000")]
#			  c("Gewerbesteuer", "umsatz", "mitarbeiter", "kapital")]
# dt_firms_clust[, kapital := log(kapital)]
dt_firms[, letterbox := !is.na(Gewerbesteuer) & !is.na(umsatz) & !is.na(kapital) &
			  rechtsform %in% c("GMBH", "GMBH_CO_KG", "AG", "LTD") &
			  mitarbeiter == "0-5" &
			  neighbours >= "100" &
			  umsatz %in% c("25000-99999", "100000-999999", "GR_1000000")]

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

#plot wzcodes
library(ggplot2)
wz_freq <- data.frame(table(wz_code)[table(wz_code) > 25])
wz_freq_2 <- data.frame(wz_code =c(46, 64, 642, 68, 70,70101, 70109),
                        Freq = c(44035,10224, 17968, 84836, 91807, 9783, 24343) / 1000)
wz_freq["lb"] = TRUE
wz_freq_2["lb"] = FALSE
df <- rbind(wz_freq, wz_freq_2)
p_letterbox <- ggplot(data = df, aes(wz_code, Freq, fill = lb)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) +
  ylab("Frequency Score")

