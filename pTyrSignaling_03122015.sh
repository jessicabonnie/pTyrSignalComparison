#!/bin/bash

xlsx2csv BarCode-pTyrSignaling-Repetitiveness.xlsx BarCode-pTyrSignaling-Repetitiveness.csv

sed -i -e 's/Men,/Men_/g' BarCode-pTyrSignaling-Repetitiveness.csv
sed -i -e 's/healthy,/healthy_/g' BarCode-pTyrSignaling-Repetitiveness.csv

awk 'NR<82{print}' BarCode-pTyrSignaling-Repetitiveness.csv > barcode1.tmp
awk 'NR>3{print}' barcode1.tmp > barcode2.tmp

cut -d, -f1-72 barcode2.tmp > barcode.csv

