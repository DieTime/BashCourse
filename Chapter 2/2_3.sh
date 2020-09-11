#!/bin/bash

echo "Is it morning? yes or no."
read timeofday

if [ $timeofday = "yes" ]
then
	echo "Good morning"
elif [ $timeofday = "no" ]
then
	echo "Good afternoon"
else
	echo "Sorry, $timeofday not recognized"
	exit 1
fi
exit 0
