#!/bin/bash

RED="\e[31;1m"
GREEN="\e[32;1m"
BLUE="\e[34;1m"
PURPLE="\e[35;1m"
DEFAULT="\e[0m"

while true; do

	clear

	echo ""
	echo "Status:"
	echo "----------------------------"

	COUNT=$(ls -l /fuzz/ 2>/dev/null | grep -v total | wc -l)

	echo -e " > queue: $GREEN$COUNT$DEFAULT"

	if [ $COUNT -lt 200 ]; then
		let nummake=1000-$COUNT
		echo -e "   - ${PURPLE}generating more...$DEFAULT"
		python3 /root/domato/c/generator.py --output_dir /fuzz/ --no_of_files $nummake >/dev/null 2>&1 &
	fi

	echo "----------------------------"

	NUMCRASHES=$(ls /fuzz/crashes/ | wc -l)
	echo ""
	echo -e "Crashes: $RED$NUMCRASHES$DEFAULT"
	echo ""

	sleep 3

done