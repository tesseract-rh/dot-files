#!/bin/bash

# if [ $(pactl info |grep Sink |awk -F'.' '{print $4}') == analog-stereo ] 
# then 
#     pactl set-card-profile 0 output:hdmi-stereo
# else 
#     pactl set-card-profile 0 output:analog-stereo
# fi


ActiveProfile=$(pactl info |awk '/Sink/ {print $3}')

BT="bluez_sink.2C_4D_79_10_86_19.a2dp_sink"
SP="alsa_output.pci-0000_00_1b.0.analog-stereo"
HDMI="alsa_output.pci-0000_00_1b.0.hdmi-stereo"

case $ActiveProfile in
	$BT )
	        pactl set-card-profile 0 output:analog-stereo
                pactl set-card-profile 8 off
		;;
	$SP )
		if [[ $(pactl set-card-profile 0 output:hdmi-stereo) ]]
		then
			:
		elif [[ $(pactl list |grep bluez_card) ]]
		then
			pactl set-card-profile 0 off
		else
			:
		fi
		;;
	$HDMI )
                pactl set-card-profile 8 a2dp_sink
                pactl set-card-profile 0 off
		;;
esac


# [tesseract@cobb i3]$ pactl set-card-profile 0 output:hdmi-stereo
# [tesseract@cobb i3]$ pactl set-card-profile 0 output:analog-stereo
# [tesseract@cobb i3]$ pactl set-card-profile 0 output:hdmi-stereo
# [tesseract@cobb i3]$ pactl set-card-profile 0 off



# if [ "$a" -ge 10 ]
# then
#     :
# elif [ "$a" -le 5 ]
# then
#     echo "1"
# else
#     echo "2"
# fi
