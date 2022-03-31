library(soilDB)
library(aqp)
library(raster)
library(sharpshootR)
library(rgdal)
library(rgeos)

# set up selected set in NASIS with desired sites/pedons
# 
# get pedon data
x <- fetchNASIS()

# keep only those pedons with real coordinates
good.idx <- which(!is.na(x$x_std))
x <- x[good.idx, ]

#iniitalize spatial coordinates
coordinates(x) <- ~ x_std + y_std

# get/set spatial reference system
proj4string(x) <- '+proj=longlat +datum=WGS84'

# remove Organic horizons
x.2 <- subsetHz(x, !grepl("O", x$hzname))
list(unique(x.2$hzname))

#get surface texture and add to site attributes
site(x.2)$surface_texture <- x.2[, 1]$texcl

#calculate soil depth for each profile. Be careful since if describer only described upper 100 cm the function will assume the soil is only 100 cm deep 
#x.2$depth <- profileApply(x.2, estimateSoilDepth, no.contact.depth = 225, no.contact.assigned = 250)

x.2$depth_to_Cd <- profileApply(x.2, estimateSoilDepth, p = "Cd",  no.contact.depth = 0, no.contact.assigned = NA)
x.2$depth_to_Cr <- profileApply(x.2, estimateSoilDepth, p = "Cr",  no.contact.depth = 0, no.contact.assigned = NA)
x.2$depth_to_R <- profileApply(x.2, estimateSoilDepth, p = "R",  no.contact.depth = 0, no.contact.assigned = NA)
x.2$soildepth <- profileApply(x.2, estimateSoilDepth, p = "Cd|R|Cr",  no.contact.depth = 0, no.contact.assigned = NA)

# extract spatial data + site level attributes
x.sp <- as(x.2, 'SpatialPointsDataFrame')

# set desired columns 
x.sp <- x.sp[, c("pedon_id","taxonname", "taxonkind", "surface_texture", "taxpartsize", "ecositenm", "hillslopeprof", "slope_field", "geomposhill", "soildepth","depth_to_R", "depth_to_Cr", "depth_to_Cd", "bedrckdepth", "bedrckkind", 'pmkind', 'pmorigin')]

# write to SHP
# output CRS is CGS WGS84
writeOGR(x.sp, dsn='C:/geodata/projectdata', layer='Duxbury_pedons_3_31_2022', driver='ESRI Shapefile', overwrite_layer=TRUE)
