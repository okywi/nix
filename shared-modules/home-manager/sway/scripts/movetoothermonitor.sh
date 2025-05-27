otherOutput=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused == false) | .name' | paste -sd, -)
workspace=$(swaymsg -t get_workspaces | jq --arg otherOutput "$otherOutput"\
  '.[] | select(.visible == true) | select(.output == $otherOutput) | .name')
swaymsg move container to workspace $workspace
