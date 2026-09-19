#!/bin/bash
LOCKFILE="/tmp/battery.lock"

# Check if lockfile exists and is stale
if [[ -f "$LOCKFILE" ]]; then
    if ! flock -n "$LOCKFILE" true; then
        echo "Script already running! Exiting."
        exit 1
    else
        # Lockfile exists but isn't locked (stale)
        rm -f "$LOCKFILE"
    fi
fi

(
    flock -n 9 || exit 1
    while [ true ]; do
        battery_level="$(cat /sys/class/power_supply/BAT0/capacity)"
        battery_status="$(cat /sys/class/power_supply/BAT0/status)"

        if [[ "$battery_level" -le "5" && "$battery_status" == "Discharging" ]]; then
            notify-send -i battery-empty -t 5000 -u normal "Battery Critical" "Battery level is ${battery_level}%"
        fi
        sleep 30
    done
) 9>"$LOCKFILE"

