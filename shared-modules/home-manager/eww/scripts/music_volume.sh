get_sink() {
    ID=$(pw-dump | jq -r '
                  .[] |
                  select(
                    .info.props."application.name"=="Chromium" and
                    .info.props."media.class"=="Stream/Output/Audio"
                  ) |
                  .id
                ')
    echo $ID
}


pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    ID=$(get_sink)
    if [[ -z "$ID" ]]; then
      echo $(eww get song_volume)
      continue
    fi
    wpctl get-volume $ID | cut -d' ' -f2 | awk '{printf "%.0f\n", $1 * 100}'
done