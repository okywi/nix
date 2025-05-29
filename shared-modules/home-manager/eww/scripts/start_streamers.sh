LOCK_FILE="/run/lock/streamers.lock"

# Check if the lock file exists
if [[ -f "$LOCK_FILE" ]]; then
    echo "Script is already running. Exiting."
    exit 1
fi

# Create the lock file
touch "$LOCK_FILE"

# Ensure the lock file is removed when the script exits
trap 'rm -f "$LOCK_FILE"' EXIT

nix-shell ~/.config/eww/scripts/shell.nix --run '
while [ true ]; do
    python $HOME/.config/eww/scripts/streams_api.py > /run/lock/streamers
    sleep 60
done'

