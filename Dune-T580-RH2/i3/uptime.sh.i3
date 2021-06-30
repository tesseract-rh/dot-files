#!/bin/bash
#
# Author: Raphael P. Ribeiro <raphaelpr01@gmail.com> 

# echo ""$d"d"$h"h"$m"m"

i3status | while :
do
    read line
    uptime=$(</proc/uptime)
    uptime=${uptime%%.*}
    
    s=$(( uptime%60 ))
    m=$(( uptime/60%60 ))
    h=$(( uptime/60/60%24 ))
    d=$(( uptime/60/60/24 ))
    echo ""$d"d:"$h"h:"$m"m | $line" || exit 1
done

## awk '{print int($1/3600)":"int(($1%3600)/60)":"int($1%60)}' /proc/uptime
