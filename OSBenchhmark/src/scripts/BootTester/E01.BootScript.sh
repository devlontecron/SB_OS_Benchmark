#!/bin/bash
instance[0]='c4.large' 
instance[1]='c4.xlarge'
instance[2]='c4.2xlarge' 
instance[3]='m4.large' 
instance[4]='m4.xlarge' 
instance[5]='m4.2xlarge' 
target="<html><body>Hello</body></html>" 
time1=0 
time2=0
#echo Launch Instance
for i in {0..5} 
do 
for loop in {1..10} 
do
#echo ">$i"
EC2=$(aws ec2 run-instances --image-id ami-518dd22b --count 1 --instance-type "${instance[i]}" --key-name devin --security-groups OSvUbuntu) >> output.log
echo ">$EC2">> output.log
time1=( $(($(date +%s%N)/1000000)) )
sleep 5 
ip=$(aws ec2 describe-instances --filters "Name=network-interface.group-name, Values=OSvUbuntu" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)
echo ">$ip" >> output.log
Iid=$(aws ec2 describe-instances --filters "Name=ip-address, Values="${ip}"" --query "Reservations[*].Instances[*].InstanceId" --output=text)
echo ">$Iid" >> output.log
isNotRunning=1;
#While no response from server
while [ $isNotRunning = 1 ] 
do
  #get ec2 instance ip and save it
  recieved=$(curl -X GET "${ip}":8081/hello/hello) >> output.log
  #echo ">$recieved" set flag is found
  if [ "$recieved" == "$target" ]
  then
    time2=$(($(date +%s%N)/1000000))
    isNotRunning=0
  fi 
done 
diff=$(echo "$time2 - $time1 " | bc) 
echo "E01,${instance[i]},Ubuntu,1,HelloTomcat,${loop},Time(ms)=,${diff}"
#echo ">Terminating instance ID=${Iid}"
aws ec2 terminate-instances --instance-ids ${Iid} >> output.log 
while [ "$ip" != "" ] 
do 
ip=$(aws ec2 describe-instances --filters "Name=network-interface.group-name, Values=OSvUbuntu" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text) 
done 
done 
echo "" 
done
