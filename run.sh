#!/bin/bash

SOURCE_URL="https://datosabiertos.navarra.es/datastore/dump/1b600bb6-a6a7-43c7-a551-23ebd5ade374?format=csv&bom=True"
DATA_FILENAME=data_$(date -I).csv

####################
# DATA ACQUISITION #
####################

# Download opendata official CSV source
wget $SOURCE_URL -O $DATA_FILENAME


#######################
# DATA TRANSFORMATION #
#######################

## Get columns 2, 3 and 7
gawk -i inplace -F"," '{print $2",",$3","$6",",$7}' $DATA_FILENAME

## Remove first line
sed -i '1d' "$DATA_FILENAME" &&

## Add custom columns at the first line
sed -i "1s/^/$(cat columns)\n/" "$DATA_FILENAME" &&

## Remove double quotes
sed -i 's/"//g' "$DATA_FILENAME" &&

## Remove unhandled html
sed -i '/^<!DOCTYPE html.*$/,$d' "$DATA_FILENAME" &&


#############
# DATA LOAD #
#############

## Generate plot
python plot.py
