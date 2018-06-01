#!/bin/bash

   calcs[1]='100'
   calcs[2]='1000'
   calcs[3]='10000'
   calcs[4]='100000'
   calcs[5]='250000'
   calcs[6]='20'
   calcs[7]='100'
   calcs[8]='1000'

   loops[1]='20'
   loops[2]='20'
   loops[3]='20'
   loops[4]='20'
   loops[5]='20'
   loops[6]='1000'
   loops[7]='10000'
   loops[8]='50000'

echo -e "Threads,Calcs,Loops,Sleep,TotalArrayTime,AvgArrayTime,TotalCalcTime,AvgCalcTime,ElapsTime,SleepTime" > output.csv

for((q = 1; q<=8; q++))
do

for((i = 1; i<=10; i++))
do
   sleep=10
   thread=($i)

    for((k = 1; k<=13; k++))
    do

   echo --Running Test $q.$i.$k
   output=`sudo ./calcs.sh "${calcs[q]}" "${loops[q]}" "$thread" "$sleep" >temp.txt`
   formatted= `./jsonParse.sh temp.txt >> output.csv` 
   avg=`./jsonParse.sh temp.txt >> expTemp.csv`
   echo --Test Complete
done
data=`./dataParse.sh expTemp.csv >> output.csv`
rm expTemp.csv
rm temp.txt
done
done
