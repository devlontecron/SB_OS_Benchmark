#!/bin/bash

file=$1

#output=cat $file | cut -d, -f 9,10


avgArr=`tail -n+5 $file | awk -F"," '{avgArrSum+=$6} {n++} END{print avgArrSum/(NR)}'`
avgCalc=`tail -n+5 $file | awk -F"," '{avgCalcSum+=$8} END{print avgCalcSum/(NR)}'`
avgElaps=`tail -n+5 $file | awk -F"," '{avgElapSum+=$9} END{print avgElapSum/(NR)}'`
avgSleep=`tail -n+5 $file | awk -F"," '{avgSleepSum+=$10} END{print avgSleepSum/(NR)}'`

echo -e '\n',,,,,$avgArr,,$avgCalc,$avgElaps,$avgSleep,Avg
 