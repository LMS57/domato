#!/bin/bash

FUZZDIR=/fuzz
SAVEDIR=/savedtests
LOG=/fuzzlog
TIMEOUT=5

savecounter=0

while true; do

	if [ $(ls $FUZZDIR/ | wc -l) -eq 0 ]; then
		sleep 2
		continue
	fi

	TEST=$(ls $FUZZDIR/ | head -n1)


	OUTPUT=$(gcc -pass-exit-codes -o /tmp/a.out $FUZZDIR/$TEST 2>/dev/null)
	RET=$?

	if [ $RET -ne 1 ]; then

		if [ $RET -eq 0 ]; then
			echo "COMPILATION SUCCESS $TEST" >> $LOG

		elif [ $RET -eq 4 ]; then
			echo "C FRONTEND COMPILER ERROR $TEST" >> $LOG

		elif [ $RET -eq 153 ]; then
			echo "MEMORY LEAK $TEST" >> $LOG

		elif [ $RET -eq 255 ]; then
			echo "EXCEPTION $TEST" >> $LOG
		
		else
			echo -e "\e[31;1mUNKNOWN CRASH (ret:$RET)\e[0m $TEST" >> $LOG
		fi

		mv $FUZZDIR/$TEST $SAVEDIR/$savecounter:$RET.c
		let savecounter=$savecounter+1

	else

		# echo "STANDARD COMPILER ERROR"
		rm $FUZZDIR/$TEST

	fi
	sleep 0.1
done