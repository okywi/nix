prev_title=""
while true; do
  current_title=$(hyprctl activewindow -j | jq -r '.title')
  if [[ "$current_title" != "$prev_title" ]]; then
    if [[ "$current_title" == "null" ]]; then
      echo "desktop"
    else
      echo "$current_title"
    fi

    prev_title="$current_title"
  fi
  sleep 0.05
done