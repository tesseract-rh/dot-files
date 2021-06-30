#!/bin/bash

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: `basename $0` [sink_index] [up|down|min|max]"
    exit $E_BADARGS
fi

SINK=$1

# STEP=3932    # volume: front-left: 3932 /   6% / -73.31 dB,   front-right: 3932 /   6% / -73.31 dB
STEP=3277    # volume: front-left: 3277 /   5% / -78,06 dB,   front-right: 3277 /   5% / -78,06 dB
MAXVOL=65536 # volume: front-left: 65536 / 100% / 0.00 dB,   front-right: 65536 / 100% / 0.00 dB

# grabs the value of the ACTIVE sink:
VOL=$(pacmd list-sinks | awk '{RS="active port"}/RUNNING/' | awk '/\tvolume:/ {print $3}')

case $2 in
up)
    VOLUME="$(( $VOL+$STEP ))";;
down)
    VOLUME="$(( $VOL-$STEP ))";;
max)
    pactl set-sink-volume $SINK $MAXVOL > /dev/null
    exit 0;;
min)
    pactl set-sink-volume $SINK 0 > /dev/null
    exit 0;;
*)
    echo "Usage: `basename $0` [sink_index] [up|down|min|max]"
    exit 1;;
esac


if [ $VOLUME -gt $MAXVOL ]; then
    VOLUME=$MAXVOL
elif [ $VOLUME -lt 0 ]; then
    VOLUME=0
fi


pactl set-sink-volume $SINK $VOLUME > /dev/null


# VOLSHOW=$(pacmd list-sinks | grep "volume" | head -n1 | awk '{print $5}' |cut -d "%" -f 1)

# if [ "$VOLSHOW" = "0" ]; then
#         icon_name="notification-audio-volume-off"
#     else
#         if [ "$VOLSHOW" -lt "33" ]; then
#             icon_name="notification-audio-volume-low"
#         else
#             if [ "$VOLSHOW" -lt "67" ]; then
#                 icon_name="notification-audio-volume-medium"
#             else
#                 icon_name="notification-audio-volume-high"
#             fi
#         fi
# fi

# notify-send " " -i $icon_name -h int:value:$VOLSHOW -h string:synchronous:volume
