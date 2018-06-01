#!/bin/bash

   fibo[1]='100'
   fibo[2]='1000'
   fibo[3]='10000'
   fibo[4]='100000'


echo -e "run_id,thread_id,json,elapsed_time,sleep_time_ms,fiboNum" > fibOutput.csv


for((q = 1; q<=4; q++))
do

for((i = 1; i<=10; i++))
do
   sleep=100
   thread=($i)

    for((k = 1; k<=13; k++))
    do

   echo --Running Test $q.$i.$k
   output=`sudo ./testFibParAdj.sh "$k" "$thread" "${fibo[q]}" > temp1.csv`
   formatted= `./fiboDataParse.sh temp1.csv`
   finalOut= `cat temp1.csv >> fibOutput.csv` 
   echo --Test Complete
done
rm temp1.csv
done
done