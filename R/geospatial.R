
bayern = read_sf("data/bayern_gemeinden/VerwaltungsEinheit.shp")
bayern = bayern[bayern$art == "Gemeinde", ]

# tmap_options(check.and.fix = TRUE)
# tmap_mode("view")

tm_shape(bayern) +
  tm_polygons()
