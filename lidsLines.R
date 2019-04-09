## Produces a .csv ready for import to a GIS to display CDW LIDS transects as lines.
## Resutling .csv created in working directory loads via Well Known Text (wkt) field, per site's UTM projection
## Inputs are transect distance, site/plot-type specific LIDSlist and site spatial information from SSL
## By Greg Chapman, last updated 20190314

library(dplyr)
library(splitstackshape)
library(sp)
library(rgeos)

###### INPUTS ######

## Specify transect distance (m) per protocol Appendix D

  distance <- 300

#### Download plot/lids files to working directory

## Site-specific spatial info from
##  https://neoninc.sharepoint.com/sites/fopscollaboration/FSU%20Only%20Documents/Forms/PlotIDs.aspx

  SSL_plots <- "D02_SERC_UniquePlotIDsandSamplingModules_2019.csv"

## Site/bout specific LIDSlist from
##  https://neoninc.sharepoint.com/sites/fopscollaboration/FSU%20Only%20Documents/Forms/CdwLids.aspx

  SSL_lids <- "SERC_tower_lidsList.csv"

## Run list.files() to copy/paste if needed
  
###### End Inputs ######


## Loads source csv from working directory

plotsOrig <- read.csv(SSL_plots)
lids <- read.csv(SSL_lids)

## Extracts just CDW plots from plot list and removes unneeded columns
plotsCDW <- select(subset(plotsOrig, coarseDownWood_cdw == "x"),
                  mortonOrder, plotID, siteID, nlcdClass, plotType,
                  subtype, moduleCode, plotCode, latitude_centroid, longitude_centroid,
                  easting_centroid, northing_centroid, datum, utmZone)

## Expand LIDSlist to three rows per plot - https://stackoverflow.com/questions/2894775/
lids_expand <- lids[rep(seq.int(1,nrow(lids)), 3), 1:ncol(lids)]

## Add cumulative ID per plotID - https://stackoverflow.com/questions/31259932/ req library(splitstackshape)
lids_expand_ID <- getanID(lids_expand, "plotID")

## Create column with uniqueTransectID - https://stackoverflow.com/questions/18115550/
lids_expand_ID$plotID_Lids <- paste0(lids_expand_ID$plotID,"_",lids_expand_ID$.id)

## Sort for readability
lids_sort <- lids_expand_ID[order(plotID_Lids) , ]

## Assign appropriate lidsAngle to single column
lids_sort$lidsFinal <- ifelse(lids_sort$.id==1,lids_sort$lidsAngle1,
                              ifelse(lids_sort$.id==2,lids_sort$lidsAngle2,
                                     ifelse(lids_sort$.id==3,lids_sort$lidsAngle3,0)))


## Merge spatial info to lidsList and remove unneeded columns
lids_spatial <- within(
                    merge(lids_sort, plotsCDW, by = c("plotID")),
                    rm(lidsAngle1,lidsAngle2,lidsAngle3,remarks,.id))

## Calculate UTM endpoints
lids_spatial$easting_end <- lids_spatial$easting_centroid + ((distance+3)*sin(lids_spatial$lidsFinal*pi/180))
lids_spatial$northing_end <- lids_spatial$northing_centroid + ((distance+3)*cos(lids_spatial$lidsFinal*pi/180))


## Concatenate WKT
## Excel =CONCATENATE("LINESTRING(",[east start]," ",[north start],",",[east end]," ",[north end],")")
lids_spatial$wkt <- with(lids_spatial, paste0(
  "LINESTRING(",easting_centroid," ",northing_centroid,",",easting_end," ",northing_end,")"))

## Final output file
write.csv(lids_spatial, file = 
            paste(lids_spatial$siteID[1], "CDW", 
            lids_spatial$plotType[1], "LIDSline", 
              paste0("UTM", lids_spatial$utmZone[1]),
            "wkt.csv", sep="_"))

####To do
## Automate creation of shapefile and/or kml 
## via sp, rgeos, maptools, rgdal


##Simple plot of wkt data
line.sp <- SpatialLinesDataFrame(readWKT(lids_spatial$wkt[1]), 
                                   data=data.frame(OBJECTID=lids_spatial$lidsFinal[1]))

for (n in 2:length(lids_spatial$lidsFinal)) {
  line.sp <- rbind(line.sp, 
                    SpatialLinesDataFrame(readWKT(lids_spatial$wkt[n]), 
                                           data.frame(OBJECTID=lids_spatial$lidsFinal[n])))
}

plot(line.sp, axes = 1)
