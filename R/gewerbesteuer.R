dt_bw_gewerbst <- openxlsx::read.xlsx("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "bw", startRow = 3)
dt_by_gewerbst <- openxlsx::read.xlsx("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "by", startRow = 3)

read_dt_gewerb <- function(file, sheet) {
	df <- openxlsx::read.xlsx(file, sheet, startRow = 3)
	setDT(df)
	colnames(df) <- c("year", "fed_state", "reg_key", "gem_key", "gemeinde",
			  "population", "Grundsteuer_A", "Grundsteuer_B", "Gewerbesteuer")
	df_filter <- df[, "year" := NULL]
	df_filter[!is.na(fed_state),]
}

bw_gewerbest <- read_dt_gewerb("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "bw")
by_gewerbest <- read_dt_gewerb("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "by")
dt_gwsteuer <- rbind(bw_gewerbest, by_gewerbest)
dt_gwsteuer$fed_state <- factor(dt_gwsteuer$fed_state, labels = c("baden_wuertenberg", "bavaria"))
