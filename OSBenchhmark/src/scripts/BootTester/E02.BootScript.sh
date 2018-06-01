#!/bin/bash
instance[0]='c4.large' 
instance[1]='c4.xlarge'
instance[2]='c4.2xlarge' 
instance[3]='m4.large' 
instance[4]='m4.xlarge' 
instance[5]='m4.2xlarge' 

#echo Launch Instance
for i in {0..5} 
do 

#echo ">$i"
EC2=$(aws ec2 run-instances --image-id ami-0a237370 --count 1 --instance-type "${instance[i]}" --key-name devin --security-groups OSvUbuntu) >> output.log
echo ">$EC2">> output.log
sleep 5 
ip=$(aws ec2 describe-instances --filters "Name=network-interface.group-name, Values=OSvUbuntu" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)
echo ">$ip" >> output.log
Iid=$(aws ec2 describe-instances --filters "Name=ip-address, Values="${ip}"" --query "Reservations[*].Instances[*].InstanceId" --output=text)
echo ">$Iid" >> output.log

sleep 30

./calcsRunner.sh

#echo ">Terminating instance ID=${Iid}"
aws ec2 terminate-instances --instance-ids ${Iid} >> output.log 
while [ "$ip" != "" ] 
do 
ip=$(aws ec2 describe-instances --filters "Name=network-interface.group-name, Values=OSvUbuntu" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text) 
done 
 
echo "" 
done
