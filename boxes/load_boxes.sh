#!/bin/bash

pattern='(.*)_(.*).box'

for box in `ls *.box`
do
	if [[ $box =~ $pattern ]]
	then
		box_name=${BASH_REMATCH[1]}
		type=${BASH_REMATCH[2]}

		echo "$box_name => $type"
		vagrant box remove $box_name $type
		vagrant box add $box_name $box
	else
		echo "Not sure what $box is, skipping"
	fi
done
