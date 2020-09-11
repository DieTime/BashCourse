#!/bin/bash
#Exercise 2.8
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes | Yes | YES | y)
		echo "Good Morning"
		echo "Up bright and early this morning"
		;;
	[nN]* )
		echo "Good Afternoon"
		;;
	*  )
		echo "Sorry, answer not recognized"
		echo "Please answer yes or no"
		exit 1
		;;
esac
exit 0

