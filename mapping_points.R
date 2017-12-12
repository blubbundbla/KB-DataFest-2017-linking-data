
##################
# Hackathon Phenoscape
# aim: map phenotypes onto a map
# Dec 12, 2017
# authors: 
# version: 0.001
####################

library(rgdal)

##########

### set working directory
#wd <- "/home/blubb/Documents/R/"
wd <- "/home/blubb/sync-TP-T470s/R/mapping/"
setwd(wd)



# load occurence - taxa table
occ_data<-readRDS('/home/blubb/sync-work/Big_Genera/finished/cleaned_plus/Astragalus/no_outlier_occ.rda')

# name columns
names(occ_data)[2]<- "longitude"
names(occ_data)[3]<- "latitude"

head(occ_data)




###################3

par(mfrow=c(1,1), mar=c(4,4,1,1))


####load shapefiles
# Natural Earth shape files -- global (Robinson) projections
# get shapefiles from http://www.naturalearthdata.com
shape_path <- "/home/blubb/sync-TP-T470s/R/mapping/shapefiles/"
coast_shapefile <- paste(shape_path, "ne_50m_coastline.shp", sep="")
ocean_shapefile <- paste(shape_path, "ne_50m_ocean.shp", sep="")
admin0_shapefile <- paste(shape_path, "ne_50m_admin_0_countries.shp", sep="")
admin1_shapefile <- paste(shape_path, "ne_50m_admin_1_states_provinces_lakes.shp", sep="")
lakes_shapefile <- paste(shape_path, "ne_50m_lakes.shp", sep="")
bb_shapefile <- paste(shape_path, "ne_50m_wgs84_bounding_box.shp", sep="")
grat30_shapefile <- paste(shape_path, "ne_50m_graticules_30.shp", sep="")


layer <- ogrListLayers(coast_shapefile)
coast_lines <- readOGR(coast_shapefile, layer=layer)

layer <- ogrListLayers(ocean_shapefile)
ocean_poly <- readOGR(ocean_shapefile, layer=layer)

layer <- ogrListLayers(admin0_shapefile)
admin0_poly <- readOGR(admin0_shapefile, layer=layer)

layer <- ogrListLayers(admin1_shapefile)
admin1_poly <- readOGR(admin1_shapefile, layer=layer)

layer <- ogrListLayers(lakes_shapefile)
lakes_poly <- readOGR(lakes_shapefile, layer=layer)

layer <- ogrListLayers(grat30_shapefile)
grat30_lines <- readOGR(grat30_shapefile, layer=layer)

layer <- ogrListLayers(bb_shapefile)
bb_poly <- readOGR(bb_shapefile, layer=layer)

bb_lines <- as(bb_poly, "SpatialLines")


# plot everything
plot(coast_lines, col="black")
plot(admin0_poly, bor="gray", add=TRUE)
plot(lakes_poly, bor="lightblue", add=TRUE)
plot(coast_lines, col="black", add=TRUE)

with(occ_data, points(longitude, latitude, pch=".", col="red"))

