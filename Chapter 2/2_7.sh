#!/bin/bash
#Exercise 2.7
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes | Yes | YES | y) echo "Good Morning";;
	n* | N* )            echo "Good Afternoon";;
	*  )                 echo "Sorry, answer not recognized";;
esac
exit 0

