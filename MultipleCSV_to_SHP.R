library(dplyr)
library(readr)

# get list of csvs
list <- list.files(path="S:/NRCS/290 - INV - RESOURCE INVENTORY/290 - 14 - Ecological Site Descriptions/MLRA_CSV_SameNames/", full.names = TRUE)

# read csvs 
df <- lapply(list, read_csv) 

# change MLRA 110 column to character 
df[[1]]$MLRA <- as.character(df[[1]]$MLRA) 

# join tables
master <- bind_rows(df)

# remove na rows. Used first column to identify
master.df <- test[!is.na(master$MLRA), ]

#write new CSV
write.csv(master.df, "C:/Paolucci/ESDs/CSVs/MasterCSV", encoding = 'UTF-8')


# Read CSV
x <- read.csv("C:/Paolucci/ESDs/CSVs/master.df.csv")
# inspect structure of spreadsheet 
str(x)

#initalize spatial coordinates. lat and long should match the columns in the spreadsheet where the coordinates are stored 
coordinates(x) <- ~ lat + long

#get/set spatial reference system
proj4string(x) <- '+proj=longlat +datum=WGS84'

#convert to spatial points data frame 
x.spsf<- as(x, 'SpatialPointsDataFrame')

#check structure of new file
str(x.spsf)

#write as shapefile. Specify file location (where you want to save file).
writeOGR(x.spsf, dsn='C:/geodata/projectdata', layer='pESD_datapoints', driver='ESRI Shapefile', overwrite_layer=TRUE)