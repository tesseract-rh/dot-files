#!/bin/bash
# if [ $(pactl info |grep Sink |awk -F'.' '{print $4}') == analog-stereo ] 
# then 
#     pactl set-card-profile 0 output:hdmi-stereo
# else 
#     pactl set-card-profile 0 output:analog-stereo
# fi


# tesseract@Koh-i-Noor:~$ pactl move-sink-input 0 alsa_output.pci-0000_00_1b.0.analog-stereo
# tesseract@Koh-i-Noor:~$ pactl move-sink-input 0 alsa_output.pci-0000_00_03.0.hdmi-stereo

index=$(pactl list sink-inputs | awk -F'"| ' '/application.process.session_id/ {print $4}')

if [ $(pactl list sinks short |awk '/alsa_output.pci-0000_00_1b.0.analog-stereo/ {print $7}') == RUNNING ]
then
    pactl move-sink-input $index alsa_output.pci-0000_00_03.0.hdmi-stereo
else
    pactl move-sink-input $index alsa_output.pci-0000_00_1b.0.analog-stereo
fi

