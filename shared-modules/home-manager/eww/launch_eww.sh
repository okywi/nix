EWW="eww -c $HOME/.config/eww/"

run_eww() {
    pkill eww

    $HOME/.config/eww/scripts/start_streamers.sh &
    $HOME/.config/eww/scripts/weather.sh &

    $EWW daemon

	$EWW open-many \
        bar:primary --arg primary:screen="1" --arg primary:wsscreen="0" \
        bar:secondary --arg secondary:screen="0" --arg secondary:wsscreen="1"
}

run_eww