#!/bin/bash

file=$1

#output=`cat $file | tr -d '{ [ } ]' | tr "," "," | tr ':' ',' | tr -d '"' -f3`
#output=`cat $file | sed 's/[^0-9,.]*//g'`
#string=`cat $file`
#echo -e ${string/Output/'\n'}
#echo `perl -pe 's/(?<!^)(?=:61:)/\n/g' $file`
#echo $output



cat $file | tr -d '\n' |sed 's/THREADs=/\n/g' | sed 's/=/,/g' |sed 's/[^0-9,.]*//g'

#cat help.txt | cut -d , -f7 | cut -d \" -f01