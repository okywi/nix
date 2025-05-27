LOCK_FILE="/tmp/weather.lock"

# Check if the lock file exists
if [[ -f "$LOCK_FILE" ]]; then
    echo "Weather script is already running. Exiting."
    exit 1
fi

# Create the lock file
touch "$LOCK_FILE"

# Ensure the lock file is removed when the script exits
trap 'rm -f "$LOCK_FILE"' EXIT

while [ true ]; do 
    curl -s 'wttr.in/Leutkirch?format=%t' > /tmp/weather-temp;
    curl -s 'wttr.in/Leutkirch?format=%c' | awk '{$1=$1};1' > /tmp/weather-icon
    sleep 180
done