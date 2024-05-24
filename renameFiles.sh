#!/bin/bash

if [[ "$1" == "" ]]; then
	echo "Error: Missing start directory argument"
	exit
else
	cd "$1"
	echo Moved to $PWD
fi

if [[ "$2" == "" ]]; then
	echo "Error: Missing text match argument"
	exit
fi
if [[ "$3" == "" ]]; then
	echo "Error: Missing text replace argument"
	exit
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

check() {
	#echo "checking" $1 $2 $3

	for item1 in *; do

		nextItem=$item1
		if [[ "$item1" == "$1"* ]]; then
			# string replace
			nextItem=${item1/$1/$2}
			echo "Renaming:" $item1 "=>" "$nextItem"
			if [[ $isDryRun == false ]]; then
				#echo "mv '${item1}' '${nextItem}'"
				mv "$item1" "$nextItem"
			fi
		fi

		nextLevel=$(($3-1))
		#echo nextLevel "$nextLevel" nextItem "$nextItem"
		if [[ "$nextLevel" -gt 0 ]] && [[ -d "$nextItem" ]] && [[ "$nextItem" != *".logicx" ]] && [[ "$nextItem" != *".logicx/" ]]; then
			cd "$nextItem"

			check $1 $2 $(($3-1))

			cd ..
		fi
	done
}

find="$2"
replace="$3"
numLevels="$4"
echo "Updating!" $find "=>" $replace

check "$find" "$replace" "$numLevels"
