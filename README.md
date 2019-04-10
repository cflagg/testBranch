# CDW-lidsLines
Produces a .csv ready for import to a GIS to display CDW LIDS transects as lines.

Resulting .csv created in working directory loads via Well Known Text (wkt) field, per site's UTM projection.

Inputs are transect distance, site/plot-type specific LIDSlist and site spatial information from SSL.

File is confirmed compatible with QGIS, not yet tested with ArcGIS.

"NEON_CDW_transects_wkt.qml" is a QGIS style file to help display the resulting layer once within QGIS.

## Instructions

### Running the Code

1. Download your site-specific spatial info (plotID) and lids angle files from the SSL, and place them in the 'CDW-lidsLines' directory. Links to the Collaboration Library are included as comments in the code.

   * Note: Some sites have both tower and distributed lids angles saved as tabs in a single .xlsx file. For the code to work, each tab will need to be saved as separate as .csv files.

2. Open the lidsLines.rProj file (and lidsLines.R, if needed). Install libraries as appropriate.

3. Set the required inputs:

   * Transect distance, per protocol Appendix D
   * plotID file name
   * Lids angle file name

<img src="https://github.com/gschapman/CDW-lidsLines/blob/master/images/inputs.PNG" width="686" height="316">

4. Source the code. A plot of the transects should appear to confirm the code was successful. **A .csv containing GIS-ready WKT line information will be created in the 'CDW-lidsLines' directory.** The file will be named similar to "SCBI_CDW_tower_LIDSline_UTM17N_wkt.csv", with site, bout type, and UTM changed as appropriate.

### Adding to GIS

(**The following instructions are for QGIS v3.0+** and presume a little familiarity with using GIS software. I do not have desktop ArcGIS handy, but I imagine the process would be similar; however the style file will obviously not work in ArcGIS. Friendly plug: QGIS is legally-free, open source software that is very good for basic cartographic and spatial processing needs, and is available at https://qgis.org)

1. Open or create a project for your site or domain. If creating a project, best to set the CRS to the correct UTM Zone (per WGS84 Datum) for the site or domain.

2. Go to Layer --> Add Layer --> Add Delimited Text Layer...

<img src="https://github.com/gschapman/CDW-lidsLines/blob/master/images/addLayer.PNG" width="714" height="415">

3. Add the wkt .csv, and fill in all dialogs/selections as appropriate (example below). Be sure to specify the correct UTM Zone and Datum.

<img src="https://github.com/gschapman/CDW-lidsLines/blob/master/images/addLayer2.PNG" width="592" height="495">

3. The file should load, but lines may be difficult to see in the default view. However, from here, symbology/styling, and exporting to shapefile of Google Earth .kml, can take place as needed.

4. As a styling starting point, the "NEON_CDW_transects_wkt.qml" style file can be applied by right-clicking on the layer's TOC entry, slecting 'Properties' and then 'Symbology', selecting 'Style' under 'Layer Rendering' at the bottom left, and then loading the style file from the 'CDW-lidsLines' directory.

<img src="https://github.com/gschapman/CDW-lidsLines/blob/master/images/applyStyle.PNG" width="678" height="311">
