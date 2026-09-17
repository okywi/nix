#!/bin/bash

while [ true ]; do
    battery_level="$(acpi -b | grep -v "Discharging" | grep -P -o '([0-9]+(?=%))')"

    if [[ "$battery_level" -le "5" ]]; then
        notify-send -i battery-empty -t 5000 -u normal "Battery Critical" "Battery level is ${battery_level}%"
    fi
	exit 0    
done