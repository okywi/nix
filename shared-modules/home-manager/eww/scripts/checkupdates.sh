LOCK_FILE="/tmp/streamers.lock"

# Check if the lock file exists
if [[ -f "$LOCK_FILE" ]]; then
    echo "Script is already running. Exiting."
    exit 1
fi

# Create the lock file
touch "$LOCK_FILE"

# Ensure the lock file is removed when the script exits
trap 'rm -f "$LOCK_FILE"' EXIT

while [ true ]; do
    checkupdates | wc -l > /tmp/checkupdates
    sleep 60
done