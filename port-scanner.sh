#!/bin/bash -e

# Bash Color
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
PURPLE='\e[0;35m'
CLEAR='\033[0m'

# Start Script
echo "Capture : $(date)"
if [ -n "$1" ] && [ -f "$1" ]; then
  while read -r line; do
    machine=$(echo "$line"| /bin/cut -d' ' -f1)|| exit 100
    ports=$(echo "$line"| /bin/cut -d' ' -f2)|| exit 101
     OLD_IFS=$OLD_IFS
     IFS=","
    for port in $ports; do
      if  (echo >/dev/tcp/"$machine"/"$port") >/dev/null 2>&1; then
        echo -e "$PURPLE $machine $CLEAR Port $YELLOW $port $CLEAR = $GREEN Connected $CLEAR"
      else
        echo -e "$PURPLE $machine $CLEAR Port $YELLOW $port $CLEAR = $RED ERROR $CLEAR"
      fi
        done
      IFS=$OLD_IFS
        done < "$1"
  else
        echo -e "$RED ERROR $CLEAR-$YELLOW No Data to Read!!$CLEAR"
  exit 103
fi
