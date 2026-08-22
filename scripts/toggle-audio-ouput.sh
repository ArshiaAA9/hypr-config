#!/bin/bash

HDMI="alsa_output.pci-0000_2d_00.1.hdmi-stereo"
ANALOG="alsa_output.pci-0000_2f_00.4.analog-stereo"

# Get current default sink name
current=$(pactl get-default-sink)

if [[ "$current" == "$HDMI" ]]; then
    pactl set-default-sink "$ANALOG"
    notify-send -t 1000 -i audio-headphones "Audio" "Switched to Headphones"
else
    pactl set-default-sink "$HDMI"
    notify-send -t 1000 -i audio-speakers "Audio" "Switched to Monitor (HDMI)"
fi
