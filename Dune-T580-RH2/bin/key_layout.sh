#!/bin/bash

LED_val=$(xset q | awk -F":  " '/LED mask/ {print $4}')

if [ $LED_val = 00000000 ]; then
    echo 'US'
elif [ $LED_val = 00001001 ]; then
    echo 'FR'
fi
