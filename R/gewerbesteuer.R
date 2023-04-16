
read_dt_gewerb <- function(file, sheet) {
	df <- openxlsx::read.xlsx(file, sheet, startRow = 3)
	setDT(df)
	colnames(df) <- c("year", "fed_state", "reg_key", "gem_key", "gemeinde",
			  "population", "Grundsteuer_A", "Grundsteuer_B", "Gewerbesteuer")
	df_filter <- df[, "year" := NULL]
	df_select <- df_filter[!is.na(fed_state),]
	df_select[, ags8 := as.integer(gem_key)]
	df_select
}

bw_gewerbest <- read_dt_gewerb("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "bw")
by_gewerbest <- read_dt_gewerb("data/hebesaetze/hebesaetze-realsteuern-8148001217005.xlsx", "by")
dt_gwsteuer <- rbind(bw_gewerbest, by_gewerbest)
dt_gwsteuer$fed_state <- factor(dt_gwsteuer$fed_state, labels = c("baden_wuertenberg", "bavaria"))

dt_gw_join <- dt_gwsteuer[, .(fed_state, ags8, gemeinde, population, Gewerbesteuer)]
dt_firms = merge(dt_gwsteuer, dt_firms, by = "ags8", all.y = TRUE)

