#!/bin/bash

file=$1

#output=cat $file | cut -d, -f 9,10


avgA=`tail -n+2 $file | awk -F"," '{avgArrSum+=$4} END{print avgArrSum/(NR-1)}'`
avgB=`tail -n+2 $file | awk -F"," '{avgCalcSum+=$5} END{print avgCalcSum/(NR-1)}'`


echo -e ,,,$avgA,$avgB,,Avg >> $file
 