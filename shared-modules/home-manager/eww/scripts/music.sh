player="--player=limusic"

get_status() {
    playerctl status $player -F | while read -r status
    do
        if [ "$status" == "Playing" ]; then
            echo ""
        elif [ "$status" == "Paused" ]; then
            echo ""
        else
            echo "x"
        fi
    done
}

next() {
    playerctl next $player
}

prev() {
    playerctl previous $player
}

toggle() {
    playerctl play-pause $player
}

get_sink() {
    ID=$(pw-dump | jq -r '
                  .[] |
                  select(
                    .info.props."application.name"=="com.github.th_ch.youtube_music" and
                    .info.props."media.class"=="Stream/Output/Audio"
                  ) |
                  .id
                ')
    echo $ID
}

change_volume() {
    if [[ $1 == "up" ]]; then
        playerctl volume 0.02+ $player
    elif [[ $1 == "down" ]]; then
        playerctl volume 0.02- $player
    fi
}

set_volume() {
    volume=$(echo "scale=2; $1 / 100" | bc)
    echo $(playerctl volume $volume $player)
}

scroll_title() {
    zscroll -n true -l 25 -d 0.25 -p " " -u true "playerctl metadata --format '{{ title }} - {{ artist }}' $player" | while read -r output
    do
        if [[ -z "$output" ]]; then
            echo "-"
        else
            echo $output
        fi
    done
}


if [[ $1 == "--status" ]] then
   get_status
elif [[ $1 == "--next" ]] then
   next
elif [[ $1 == "--prev" ]] then
   prev
elif [[ $1 == "--toggle" ]] then
   toggle
elif [[ $1 == "--title" ]] then
    scroll_title
elif [[ $1 == "up" || $1 == "down" ]] then
   change_volume $1
elif [[ $1 == "--set-volume" ]] then
    set_volume $2
fi
