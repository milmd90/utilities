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

if [[ "$4" == "" ]]; then
	echo "Error: Missing number of levels to search"
	exit
fi

find="$1"
replace="$2"
numLevels="$4"
echo Updating $1 "=>" $2

check() {
	#echo "checking" $1 $2 $3

	for item1 in *; do

		nextItem=$item1
		if [[ "$item1" == "$1"* ]]; then
			# string replace
			nextItem=${item1/$1/$2}
			echo "1" $item1 "=>" "$nextItem"
			mv "$item1" "$nextItem"
		fi

		nextLevel=$(($3-1))
		#echo nextLevel "$nextLevel" nextItem "$nextItem"
		if [[ "$nextLevel" -gt 0 ]] && [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx/" ]]; then
			cd "$nextItem"

			check "$find" "$replace" $(($3-1))

			cd ..
		fi
	done
}

check "$find" "$replace" "$numLevels"