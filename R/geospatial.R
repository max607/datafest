
plz = read.csv("data/plz_geocoord.csv")

bayern = readOGR("data/bayern_gemeinden/vg5000_ebenen_1231/VG5000_GEM.shp")
leaflet(bayern) %>% addPolygons()

# bayern = opq("Bayern") %>%
#   add_osm_feature(
#     key = "place",
#     value = "region"
#   )
# 
# district_bayern = osmdata_sf(bayern)
# 
# ggplot(data.frame()) +
#   geom_sf(data = district_bayern$bbox) +
#   coord_sf()
