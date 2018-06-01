host=localhost
port=8080
test=20
fibonum=100
echo $json
    json={"\"number\"":$fibonum}
    curl -X POST -H "Content-Type: application/json" http://$host:$port/fibo/fibonacci -d $json
echo ""


