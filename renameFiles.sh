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

isDryRun=true
if [[ "$5" != "execute" ]]; then
        echo "Dry run"
else 
	echo "EXECUTING"
	isDryRun=false
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
			echo "Renaming:" $item1 "=>" "$nextItem"
			if [[ !$isDryRun ]]; then
				mv "$item1" "$nextItem"
			fi
		fi

		nextLevel=$(($3-1))
		#echo nextLevel "$nextLevel" nextItem "$nextItem"
		if [[ "$nextLevel" -gt 0 ]] && [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx" ]] && [[ "$nextItem" != *".logicx/" ]]; then
			cd "$nextItem"

			check "$find" "$replace" $(($3-1))

			cd ..
		fi
	done
}

check "$find" "$replace" "$numLevels"
