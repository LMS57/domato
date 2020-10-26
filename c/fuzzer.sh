#!/bin/bash

FUZZDIR=/fuzz
SAVEDIR=/savedtests
TIMEOUT=3

savecounter=0

while true; do

	if [ $(ls $FUZZDIR/ | wc -l) -eq 0 ]; then
		echo "Waiting for more tests..."
		sleep 2
		continue
	fi

	TEST=$(ls $FUZZDIR/ | head -n1)

	echo -n "Testing $TEST: "


	OUTPUT=$(timeout -s SIGTERM $TIMEOUT gcc -pass-exit-codes -o /tmp/a.out $FUZZDIR/$TEST 2>&1)
	RET=$?

	if [ $RET -ne 1 ]; then

		if [ $RET -eq 0 ]; then
			echo "COMPILATION SUCCESS"

		elif [ $RET -eq 4 ]; then
			echo "C FRONTEND COMPILER ERROR"

		elif [ $RET -eq 124 ]; then
			echo "TIMEOUT"

		elif [ $RET -eq 153 ]; then
			echo "MEMORY LEAK"

		elif [ $RET -eq 255 ]; then
			echo "EXCEPTION"
		
		else
			echo -e "\e[31;1mUNKNOWN CRASH (ret:$RET)\e[0m"
		fi

		mv $FUZDIR/$TEST $SAVEDIR/$savecounter:$RET.c
		let savecounter=$savecounter+1

	else

		# echo "STANDARD COMPILER ERROR"
		rm $FUZZDIR/$TEST

	fi

	sleep 0.5

done