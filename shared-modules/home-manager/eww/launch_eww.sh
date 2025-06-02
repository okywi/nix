EWW="eww -c $HOME/.config/eww/"

run_eww() {
    pkill eww

    $HOME/.config/eww/scripts/start_streamers.sh &
    $HOME/.config/eww/scripts/weather.sh &

    $EWW daemon

	$EWW open-many \
        bar:primary --arg primary:output="DP-3" --arg primary:screen="1" \
        bar:secondary --arg secondary:output="HDMI-A-1" --arg secondary:screen="0"
}

run_eww