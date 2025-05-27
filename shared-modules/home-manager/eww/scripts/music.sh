player="--player=spotify"

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

change_volume() {
    if [[ $1 == "up" ]]; then
        playerctl volume 0.02+ $player
    elif [[ $1 == "down" ]]; then
        playerctl volume 0.02- $player
    fi
}

scroll_title() {
    zscroll -n true -l 25 -d 0.25 -p " " -u true "playerctl metadata --format '{{ title }} - {{ artist }}' --player=spotify" | while read -r output
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
fi
