#!/bin/bash

if [[ "$1" == "" ]]; then
	echo "Error: Missing text match argument"
	exit
fi
if [[ "$2" == "" ]]; then
	echo "Error: Missing text replace argument"
	exit
fi

if [[ "$3" == "" ]]; then
	echo "Error: Missing start directory argument"
	exit
else
	cd "$3"
	echo Moved to $PWD
fi

echo Updating $1 "=>" $2

set -e
for item1 in *; do

	nextItem=$item1
	if [[ "$item1" == "$1"* ]]; then
		# string replace
		nextItem=${item1/$1/$2}
		echo "1" $item1 "=>" "$nextItem"
		mv "$item1" "$nextItem"
	fi

	#echo 1 nextItem "$nextItem"

	if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
		cd "$nextItem"
		for item2 in *; do

			nextItem=$item2
			if [[ "$item2" == $1* ]]; then
				# string replace
				nextItem=${item2/$1/$2}
				echo "2  " $item2 "=>" "$nextItem"
				mv "$item2" "$nextItem"
			fi

			#echo 2 nextItem "$nextItem"

			if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
				cd "$nextItem"
				for item3 in *; do

					nextItem=$item3
					if [[ "$item3" == $1* ]]; then
						# string replace
						nextItem=${item3/$1/$2}
						echo "3   " $item3 "=>" "$nextItem"
						mv "$item3" "$nextItem"
					fi

					#echo 3 nextItem "$nextItem"

					if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
						cd "$nextItem"
						for item4 in *; do

							nextItem=$item4
							if [[ "$item4" == $1* ]]; then
								# string replace
								nextItem=${item4/$1/$2}
								echo "4    " $item4 "=>" "$nextItem"
								mv "$item4" "$nextItem"
							fi

							#echo 4 nextItem "$nextItem"

							if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
								cd "$nextItem"
								for item5 in *; do

									nextItem=$item5
									if [[ "$item5" == $1* ]]; then
										# string replace
										nextItem=${item5/$1/$2}
										echo "5     " $item5 "=>" "$nextItem"
										mv "$item5" "$nextItem"
									fi

									#echo 5 nextItem "$nextItem"

								done
								cd ..
							fi

						done
						cd ..
					fi

				done
				cd ..
			fi

		done
		cd ..
	fi

done