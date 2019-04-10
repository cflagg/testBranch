# CDW-lidsLines
Produces a .csv ready for import to a GIS to display CDW LIDS transects as lines.

Resultling .csv created in working directory loads via Well Known Text (wkt) field, per site's UTM projection.

Inputs are transect distance, site/plot-type specific LIDSlist and site spatial information from SSL.

File is confirmed compatible with QGIS, not yet tested with ArcGIS.

"NEON_CDW_transects_wkt.qml" is a QGIS style file to help display the resulting layer once within QGIS.

## Instructions

### Running the Code

1. Download your site-specific spatial info (plotID) and lids angle files from the SSL, and place them in the 'CDW-lidsLines' directory. Links to the Callaboration Library are included as comments in the code.

   * Note: Some sites have both tower and distributed lids angles saved as tabs in a single .xlsx file. For the code to work, each tab will need to be saved as separate as .csv files.

2. Open the .rProj file (and lidsLines.R, if needed). Install libraries as appropriate.

2. Set the required inputs:

   * Transect distance, per protocol Appendix D
   * plotID file name
   * Lids angle file name

<img src="https://github.com/gschapman/CDW-lidsLines/blob/master/images/inputs.PNG" width="686" height="316">

3. Source the code. A plot of the transects should appear to confirm the code was successful. **A .csv containing GIS-ready WKT line information will be created in the 'CDW-lidsLines' directory.**

### Adding to GIS

(**The following instructions are for QGIS v3.0+**. I do not have desktop ArcGIS handy, but I imagine the process would be similar; however the stlye file will obvioulsy not work in ArcGIS.)
