function get_volume() {
    pamixer --get-volume
    pactl subscribe | grep --line-buffered "sink" | while read -r _
    do
        pamixer --get-volume
    done
}

choose_icon() {
    volume=$(pamixer --get-volume)

    if [[ $(pamixer --get-mute) == true ]]; then
        echo ""
    elif [[ $volume -ge 75 ]]; then
        echo ""
    elif [[ $volume -ge 25 ]]; then
        echo ""
    elif [[ $volume -ge 0 ]]; then
        echo ""
    fi
}

function get_icon() {
    choose_icon
    pactl subscribe | grep --line-buffered "sink" | while read -r _
    do
        choose_icon
    done
}

function change_volume() {
    if [[ $1 == "up" ]]; then
        pamixer -i 5
    elif [[ $1 == "down" ]]; then
        pamixer -d 5
    fi
}

if [[ $1 == "--volume" ]]; then
    get_volume
elif [[ $1 == "up" || $1 == "down" ]]; then
    change_volume $1
elif [[ $1 == "--icon" ]]; then
    get_icon $1
fi