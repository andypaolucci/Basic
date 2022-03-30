library(soilDB)
library(aqp)
library(raster)
library(sharpshootR)

# set up local database in NASIS with desired sites/pedson
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

# extract spatial data + site level attributes
x.sp <- as(x, 'SpatialPointsDataFrame')

#write as shapefile. Specify file location (where you want to save file).
writeOGR(x.spsf, dsn='C:/geodata/projectdata', layer='pESD_datapoints', driver='ESRI Shapefile', overwrite_layer=TRUE)
