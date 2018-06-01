#!/bin/bash
calcs=$1
loops=$2
thread=$3
sleep=$4


callservice() {
calcsVar=$1
loopsVar=$2
threadVar=$3
sleepVar=$4
host=localhost
port=8080
onesecond=1000

echo "THREADs= {$threadVar},"

if [ $threadVar -eq 1 ]
  then
  echo " "
  fi
    json={"\"calcs\"":$calcsVar,"\"loops\"":$loopsVar,"\"sleep\"":$sleepVar}
    
    time1=( $(($(date +%s%N)/1000000)) )
    curl -X POST -H "Content-Type: application/json" http://$host:$port/calcs/ -d $json 
    time2=( $(($(date +%s%N)/1000000)) )
    elapsedtime=`expr $time2 - $time1`
    sleeptime=`echo $onesecond - $elapsedtime | bc -l`
    sleeptimems=`echo $sleeptime/$onesecond | bc -l`
    echo "ElapsTime= $elapsedtime SleepTime= $sleeptimems "
    if (( $sleeptime > 0 ))
    then
      sleep $sleeptimems
    fi
  
}
export -f callservice

runsperthread=`echo $loops/$thread | bc -l`
runsperthread=${runsperthread%.*}
#echo "runsperthread=$runsperthread threads=$thread totalLoops=$loops"
for (( i=1 ; i <= $thread ; i ++))
do
  arpt+=($runsperthread)
done
parallel --no-notice -j $thread -k callservice $calcs $loops $thread $sleep ::: "${arpt[@]}"


