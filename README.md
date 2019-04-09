# CDW-lidsLines
Produces a .csv ready for import to a GIS to display CDW LIDS transects as lines.

Resultling .csv created in working directory loads via Well Known Text (wkt) field, per site's UTM projection.

Inputs are transect distance, site/plot-type specific LIDSlist and site spatial information from SSL.

File is confirmed compatible with QGIS, not yet tested with ArcGIS.

"NEON_CDW_transects_wkt.qml" is a QGIS style file to help display the resulting layer once within QGIS.
