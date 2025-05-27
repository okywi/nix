
function get_volume() {
    pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | tr -d '%'
    
    pactl subscribe | grep --line-buffered "source" | while read -r _
    do
        pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | tr -d '%'
    done
}

choose_icon() {
    state=$(pactl get-source-mute @DEFAULT_SOURCE@)

    if [[ "$state" == "Mute: yes" ]]; then
        echo ""
    else
        echo ""
    fi
}

function get_icon() {
    choose_icon
    pactl subscribe | grep --line-buffered "source" | while read -r _
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