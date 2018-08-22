#!/bin/bash

regex="ELAN1300:00 04F3:3032 Touchpad\s*id=([0-9]*)"
if [[ $(xinput) =~ $regex ]]; then
    xinputId="${BASH_REMATCH[1]}"
    echo "${xinputId}"
else
    echo "not found"
fi

if [ -f /tmp/disabled-touchpad ]; then
    echo "File does exist";
    notify-send -i input-touchpad "Enabled" "Touchpad";
    xinput set-prop ${xinputId} "Device Enabled" 1
    rm /tmp/disabled-touchpad;
else
    echo "File not found";
    notify-send -i input-touchpad "Disabled" "Touchpad";
    xinput set-prop ${xinputId} "Device Enabled" 0
    echo "${xinputId}" > /tmp/disabled-touchpad;
fi
