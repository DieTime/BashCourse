#!/bin/bash
#Syncronyzer of 2 folders

# Previous hash of files
declare -A hashHistory=()

while [ : ]
do
        A=($(ls $1)) # files in first folder
	B=($(ls $2)) # files in second folder
	I=() 	     # intersections of files

	# Get intersection
	for itemA in "${A[@]}"; do
    		for itemB in "${B[@]}"; do
        		if [[ $itemA == $itemB ]]; then
            			I+=( $itemA )
            			break
        		fi
    		done
	done

	# Copy files from A to B if it's not in intersection
	for itemA in "${A[@]}"; do
		if [[ " ${I[*]} " != *"$itemA"* ]]
		then
			cp "$1/$itemA" "$2/$itemA"
			echo "Info! file $1/$itemA copied to $2/$itemA"
		fi
	done

	# Copy files from B to A if it's not in intersection
        for itemB in "${B[@]}"; do
                if [[ " ${I[*]} " != *"$itemB"* ]]
                then
                        cp "$2/$itemB" "$1/$itemB"
			echo "Info! file $2/$itemB copied to $1/$itemB"
                fi
        done

	# Compare files in intersection
	for itemI in "${I[@]}"; do
		# Get hash sum of files
		shaA=($(sha1sum "$1/$itemI"))
		shaB=($(sha1sum "$2/$itemI"))

		# If hashes not equal
		if [ "$shaA" != "$shaB" ];
		then
			# If hash history doesn't contain itemI as key - handle collision
			if [ "${hashHistory[$itemI]}" = "" ]
			then
				answer="1"
				read -p "Warning! Collision of $1/$itemI and $2/$itemI. Enter 1 or 2: " input
				answer="${input:-$answer}"
				if [ "$answer" = "1" ]
				then
					cp -fr "$1/$itemI" "$2/$itemI"
					echo "Info! $2/$itemI was overwritten by $1/$itemI"
					hashHistory[$itemI]="$shaA"
				elif [ "$answer" = "2" ]
				then
					cp -fr "$2/$itemI" "$1/$itemI"
					echo "Info! $1/$itemI was overwritten by $2/$itemI"
					hashHistory[$itemI]="$shaB"
				fi
			# If hash history contain itemI as key - finding new file and replace them
			else
				if [ "$shaA" = "${hashHistory[$itemI]}" ]
				then
					cp -fr "$2/$itemI" "$1/$itemI"
					echo "Info! $1/$itemI was overwritten by $2/$itemI"
					hashHistory[$itemI]="$shaB"
				elif [ "$shaB" = "${hashHistory[$itemI]}" ]
				then
					cp -fr "$1/$itemI" "$2/$itemI"
					echo "Info! $2/$itemI was overwritten by $1/$itemI"
					hashHistory[$itemI]="$shaA"
				# Handle collision if two wiles changed at the same time
				else
					answer="1"
                                	read -p "Warning! Collision of $1/$itemI and $2/$itemI. Enter 1 or 2: " input
                                	answer="${input:-$answer}"
                                	if [ "$answer" = "1" ]
                                	then
                                        	cp -fr "$1/$itemI" "$2/$itemI"
                                        	echo "Info! $2/$itemI was overwritten by $1/$itemI"
                                       		hashHistory[$itemI]="$shaA"
                                	elif [ "$answer" = "2" ]
					then
                                        	cp -fr "$2/$itemI" "$1/$itemI"
                                        	echo "Info! $1/$itemI was overwritten by $2/$itemI"
                                        	hashHistory[$itemI]="$shaB"
                                	fi
				fi
			fi
		# If the hashes of the files are equal - remember the hash in history
		else
			hashHistory[$itemI]="$shaA"
		fi
	done

        sleep 1
done
