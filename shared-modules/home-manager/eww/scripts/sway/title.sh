swaymsg -t subscribe -m '[ "window" ]' | while read -r event; do

# Extract the title of the focused window
event=$(echo $event | jq -r '.container.name')

# remove emoji if needed
#if [[ $(echo $event | awk '{if ($0 ~ /[^\x00-\x7F]/) print "emoji found"}') == "emoji found" ]]; then
#  echo $event | awk '{gsub(/[^\x00-\x7F]/, "")}1'
#else
    echo "$event"
#fi
done