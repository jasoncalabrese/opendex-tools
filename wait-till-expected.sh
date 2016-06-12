#!/bin/bash

GLUCOSE=$1

OLD=${2-5}	
TIME_SINCE=`cat /home/indy/cgm-loop/monitor/glucose-zoned.json | json -e "this.minAgo=(new Date()-new Date(this.dateString))/60/1000" | json -a minAgo | head -n 1`


if (( $(bc <<< "$TIME_SINCE >= $OLD") )); then
  echo "CGM Data $TIME_SINCE mins ago is old (>=$OLD), not waiting"
else
  WAIT_MINS=$(bc <<< "$OLD - $TIME_SINCE")
  echo "CGM Data $TIME_SINCE mins ago is fresh (< $OLD), waiting $WAIT_MINS mins for new data"
  time sleep ${WAIT_MINS}m
fi

