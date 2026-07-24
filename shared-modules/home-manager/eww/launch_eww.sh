EWW="eww -c $HOME/.config/eww/"

run_eww() {
    pkill eww

    $HOME/.config/eww/scripts/start_streamers.sh &
    $HOME/.config/eww/scripts/weather.sh &

    $EWW daemon

    $bar
}

run_eww