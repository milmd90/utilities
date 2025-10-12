#!/bin/bash

if [[ "$1" == "" ]]; then
	echo "Error: Missing start directory argument"
	exit
else
	cd "$1"
	echo Moved to $PWD
fi

isDryRun=true
if [[ "$2" != "execute" ]]; then
	echo "Dry run"
else 
	echo "EXECUTING"
	isDryRun=false
fi

check() {
	for item in *; do
    remove=" (1)"
		original="${item//$remove}"
	  # echo "checking:" $item $original
		if [[ "$item" == *$remove* ]] && [[ -f "./$original" ]]; then
			echo "found:" $item $original
			if [[ $isDryRun == false ]]; then
				rm "$item"
			fi
		fi

		if [[ -d "$item" ]]; then
			cd "$item"

			check

			cd ..
		fi
	done
}

check
