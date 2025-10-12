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
        DISCHARGING="$(acpi | grep "Battery 0:" | grep 'Discharging')"
        BATTERY_LEVEL="$(acpi | grep "Battery 0:" | grep -oP '(?<=, )\d+(?=%)')"

        if [ ! -z "${DISCHARGING}" ] && [ "${BATTERY_LEVEL}" -le 10 ]; then
            notify-send --icon=battery-caution "Battery level is at ${BATTERY_LEVEL}%" "Please plug in a charging cable."
        fi
        sleep 120
    done
) 9>"$LOCKFILE"