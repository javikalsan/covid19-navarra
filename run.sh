#!/bin/bash

SOURCE_URL="http://www.navarra.es/appsext/DescargarFichero/default.aspx?codigoAcceso=OpenData&fichero=coronavirus\datos_coronavirus_julio_2020.xls"
XLS_SOURCE_DATA="default.aspx?codigoAcceso=OpenData&fichero=coronavirus\datos_coronavirus_julio_2020.xls"
TEMP_DATA_FILENAME=data__$(date -I).csv
DATA_FILENAME=data_$(date -I).csv

####################
# DATA ACQUISITION #
####################

# Download opendata official source
wget $SOURCE_URL &&


#######################
# DATA TRANSFORMATION #
#######################

# Use gnumeric ssconvert tool to convert propietary xls format to csv
ssconvert "$XLS_SOURCE_DATA" "$TEMP_DATA_FILENAME" &&

# Remove first five lines
sed -i '1,5d' "$TEMP_DATA_FILENAME" &&

# Get columns 1, 3 and 12
cut -d ',' -f1,3,12 < "$TEMP_DATA_FILENAME" > "$DATA_FILENAME" &&

# Remove temporary data file
rm "$TEMP_DATA_FILENAME" &&

# Remove first line
sed -i '1d' "$DATA_FILENAME" &&

# Add custom columns at the first line
sed -i "1s/^/$(cat columns)\n/" "$DATA_FILENAME" &&

# Remove double quotes
sed -i 's/"//g' "$DATA_FILENAME" &&

# Remove original source data
rm *.xls &&


#############
# DATA LOAD #
#############

# Generate plot
python plot.py