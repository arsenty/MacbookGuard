#!/bin/bash
for i in `seq 1 5`;
  do
	echo $i
	echo `osascript GetNameAndTitleOfActiveWindow.scpt`
	sleep 1
done