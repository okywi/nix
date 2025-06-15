EWW="eww -c $HOME/.config/eww/"
if [[ $DESKTOP_SESSION == "hyprland" ]]; then
    SCREEN=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
elif [[ $DESKTOP_SESSION == "sway" ]]; then
    SCREEN=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
fi

if [[ $SCREEN == "DP-3" ]]; then
    SCREEN=1
elif [[ $SCREEN == "HDMI-A-1" ]]; then
    SCREEN=0
fi

pop_music() {
    if [ -z $($EWW active-windows | grep "music: music") ]; then
        $EWW open music --screen $SCREEN
    else
        $EWW close music
    fi
}

pop_calendar() {
    if [[ -z $($EWW active-windows | grep "calendar: calendar") ]]; then
        $EWW open calendar --screen $SCREEN
    else
        $EWW close calendar
    fi
}

pop_launcher() {
    killall rofi 2>/dev/null || ~/.config/rofi/launchers/type-1/launcher.sh
}

pop_stats() {
    if [[ -z $($EWW active-windows | grep "stats: stats") ]]; then
        $EWW open stats --screen $SCREEN
    else
        $EWW close stats
    fi
}

pop_powermenu() {
    killall rofi 2>/dev/null || ~/.config/rofi/powermenu/type-2/powermenu.sh
}

pop_audio() {
    if [[ $DESKTOP_SESSION == "hyprland" ]]; then
        hyprctl dispatch exec "pavucontrol -t 3"
    elif [[ $DESKTOP_SESSION == "sway" ]]; then
        swaymsg exec "pavucontrol -t 3"
    fi
}

pop_mic() {
    if [[ $DESKTOP_SESSION == "hyprland" ]]; then
        hyprctl dispatch exec "pavucontrol -t 4"
    elif [[ $DESKTOP_SESSION == "sway" ]]; then
        swaymsg exec "pavucontrol -t 4"
    fi
}

if [[ $1 == "--music" ]] then
    pop_music
elif [[ $1 == "--calendar" ]]; then
    pop_calendar
elif [[ $1 == "--launcher" ]]; then
    pop_launcher
elif [[ $1 == "--powermenu" ]]; then
    pop_powermenu
elif [[ $1 == "--stats" ]]; then
    pop_stats
elif [[ $1 == "--audio" ]]; then
    pop_audio
elif [[ $1 == "--mic" ]]; then
    pop_mic
fi