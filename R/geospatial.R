
# Bayern
bayern = read_sf("data/bayern_gemeinden/VerwaltungsEinheit.shp")
bayern_kreise = bayern[bayern$art == "Kreis / kreisfreie Stadt", c("name", "ags", "geometry")]
bayern_land = bayern[bayern$art == "Bundesland", c("name", "ags", "geometry")]
bayern = bayern[bayern$art == "Gemeinde", c("name", "ags", "geometry")]

# Baden-Wuerttemberg
bawue = read_sf("data/bawue_gemeinden/AX_KommunalesGebiet.shp")
colnames(bawue)[colnames(bawue) == "Schlüssel"] = "ags"
colnames(bawue)[colnames(bawue) == "Name"] = "name"
bawue_kreise = read_sf("data/bawue_kreise/AX_Gebiet_Kreis.shp")
colnames(bawue_kreise)[colnames(bawue_kreise) == "Schlüssel"] = "ags"
colnames(bawue_kreise)[colnames(bawue_kreise) == "Name"] = "name"
bawue_land = read_sf("data/bawue_land/AX_Gebiet_Bundesland.shp")
colnames(bawue_land)[colnames(bawue_land) == "Schlüssel"] = "ags"
colnames(bawue_land)[colnames(bawue_land) == "Name"] = "name"

# merge
gemeinden = rbind(bayern, bawue)
dt_gw_join$ags = paste0("0", dt_gw_join$ags8)
gemeinden = merge(gemeinden, dt_gw_join, by = "ags") # drop 175

# gemeinden mit besonders niedrigen Steuern
# gemeinden[order(gemeinden$Gewerbesteuer), ] %>% View()

# uncomment for interactive:
# tmap_options(check.and.fix = TRUE)
# tmap_mode("view")

tm_shape(rbind(bayern_kreise, bawue_kreise)) +
  tm_polygons(alpha = 0) +
tm_shape(gemeinden) +
  tm_bubbles(col = "Gewerbesteuer",
             size = 0.5, alpha = 0.9,
             palette = c("#003300", "#66CC33", "#33FF33")) +
  tm_shape(rbind(bayern_land, bawue_land)) +
  tm_polygons(alpha = 0, lwd = 1, border.col = "#333333")


# # dt_firms
# dt_firms_gemeinden = dt_firms_filter[, .N, by = c("gem_key")]
# colnames(dt_firms_gemeinden)[colnames(dt_firms_gemeinden) == "N"] = "potential_letterbox"
# gemeinden_letterbox = merge(gemeinden, dt_firms_gemeinden, by.x = "ags", by.y = "gem_key", all.y = TRUE)
# 
# tm_shape(rbind(bayern_kreise, bawue_kreise)) +
#   tm_polygons(alpha = 0) +
#   tm_shape(gemeinden_letterbox) +
#   tm_bubbles(col = "potential_letterbox",
#              size = 0.5, alpha = 0.9,
#              palette = c("lightyellow", "yellow", "darkred")) +
#   tm_shape(rbind(bayern_land, bawue_land)) +
#   tm_polygons(alpha = 0, lwd = 1, border.col = "#333333")


