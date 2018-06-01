 #!/bin/bash

 
 json={"\"number\"":100}
    time1=( $(($(date +%s%N)/1000000)) )
    curl -X POST -H "Content-Type: application/json" http://localhost:8080/fibo/fibonacci -d $json 
    time2=( $(($(date +%s%N)/1000000)) )
    elapsedtime=`expr $time2 - $time1`
    echo "$i,$threadid,$json,$elapsedtime,$sleeptimems,$fibonum"
   