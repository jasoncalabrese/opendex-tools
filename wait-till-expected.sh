#!/bin/bash

GLUCOSE=$1

OLD=${2-5}	
TIME_SINCE=$(time-since.sh $GLUCOSE)

if (( $(bc <<< "$TIME_SINCE >= $OLD") )); then
  echo "CGM Data $TIME_SINCE mins ago is old (>=$OLD), not waiting"
else
  WAIT_MINS=$(bc <<< "$OLD - $TIME_SINCE")
  echo "CGM Data $TIME_SINCE mins ago is fresh (< $OLD), waiting $WAIT_MINS mins for new data"
  time sleep ${WAIT_MINS}m
  echo "finished waiting, lets get some CGM Data"
fi

