LOCKFILE="/tmp/streamers.lock"

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
    nix-shell ~/.config/eww/scripts/shell.nix --run '
    while [ true ]; do
        python $HOME/.config/eww/scripts/streams_api.py > /tmp/streamers
        sleep 60
    done'
) 9>"$LOCKFILE"

