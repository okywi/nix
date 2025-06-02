LOCKFILE="/tmp/weather.lock"

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
        curl -s 'wttr.in/Leutkirch?format=%t' | awk '{$1=$1};1' > /tmp/weather-temp
        curl -s 'wttr.in/Leutkirch?format=%c' | awk '{$1=$1};1' > /tmp/weather-icon
        sleep 180
    done
) 9>"$LOCKFILE"

