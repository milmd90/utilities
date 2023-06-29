#!/bin/bash

if [[ "$1" == "" ]]; then
	echo "missing first argument"
	exit
fi
if [[ "$2" == "" ]]; then
	echo "missing second argument"
	exit
fi

echo Updating $1 "=>" $2

set -e
for item1 in ../*; do

	nextItem=$item1
	echo 1 nextItem "$nextItem"
	if [[ "$item1" == "$1"* ]]; then
		echo HIT1  "$item1"
		# string replace
		nextItem=${item1/$1/$2}
		echo "1" $item1 "=>" "$nextItem"
		mv "$item1" "$nextItem"
	fi

	if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
		cd "$nextItem"
		for item2 in *; do

			nextItem=$item2
			echo 2 nextItem "$nextItem"
			if [[ "$item2" == $1* ]]; then
				echo HITT2  "$item2"
				# string replace
				nextItem=${item2/$1/$2}
				echo "2  " $item2 "=>" "$nextItem"
				mv "$item2" "$nextItem"
			fi

			if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
				cd "$nextItem"
				for item3 in *; do

					nextItem=$item3
					echo 3 nextItem "$nextItem"
					if [[ "$item3" == $1* ]]; then
						echo HITTT3  "$item3"
						# string replace
						nextItem=${item3/$1/$2}
						echo "3   " $item3 "=>" "$nextItem"
						mv "$item3" "$nextItem"
					fi

					if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
						cd "$nextItem"
						for item4 in *; do

							nextItem=$item4
							echo 4 nextItem "$nextItem"
							if [[ "$item4" == $1* ]]; then
								echo HITTTT4  "$item4"
								# string replace
								nextItem=${item4/$1/$2}
								echo "4    " $item4 "=>" "$nextItem"
								mv "$item4" "$nextItem"
							fi

							if [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
								cd "$nextItem"
								for item5 in *; do

									nextItem=$item5
									echo 5 nextItem "$nextItem"
									if [[ "$item5" == $1* ]]; then
										echo HITTTTT5  "$item5"
										# string replace
										nextItem=${item5/$1/$2}
										echo "5     " $item5 "=>" "$nextItem"
										mv "$item5" "$nextItem"
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
		cd ..
	fi

done