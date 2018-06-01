#!/bin/bash



    json={"\"calcs\"":1000,"\"loops\"":1000,"\"sleep\"":1}
    
    curl -X POST -H "Content-Type: application/json" http://localhost:8080/calcs/ -d $json 
    

