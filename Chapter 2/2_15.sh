#!/bin/bash

trap 'rm -f /tmp/my_tmp_file_$$' INT
echo Creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "Press CTRL-C to interrupt..."
while [ -f /tmp/my_tmp_file_$$ ]; do
	echo File exists
	sleep 1
done

trap INT
echo Creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "Press CTRL-C to interrupt..."
while [ -f /tmp/my_tmp_file_$$ ]; do
	echo File exists
	sleep 1
done

echo We never get here
exit 0
