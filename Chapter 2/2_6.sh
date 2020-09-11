#!/bin/bash
#Exercise 2.6
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes) echo "Good Morning";;
	no ) echo "Good Afternoon";;
	y  ) echo "Good Morning";;
	n  ) echo "Good Afternoon";;
	*  ) echo "Sorry, answer not recognized";;
esac
exit 0

