#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x) modified by okywi
## Github  : @adi1090x
#
## Applets : Record

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Record'
mesg="DIR: `xdg-user-dir PICTURES`/Screenrecordings"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='6'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='6'
	win_width='200px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='6'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
	win_width='670px'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Record Desktop"
	option_2=" Record Area"
	option_3=" Record Window"
	option_4=" Record Desktop with audio"
	option_5=" Record Area with audio"
    option_6=" Record Window with audio"
else
	option_1=" "
	option_2=" "
	option_3=" "
	option_4=" "
	option_5=" "
    option_6=" "
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Screenshot
dir="`xdg-user-dir VIDEOS`/Screenrecordings"
file=$(date +%H:%M:%S_%d-%m-%Y)_screenrecording.mp4

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

notify_finish() {
	notify-send "Finished recording" -t 800 -e
}

# take shots
recorddesktop () {
	wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file" -g "$(slurp -o)"
	notify_finish
}

recordarea () {
    wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file" -g "$(slurp -d)"
	notify_finish
}

recordwin () {
    #region=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"' | slurp)
	region=$(hyprctl clients -j | jq -r --arg ws "$(hyprctl activeworkspace -j | jq -r '.id')" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -r)
	wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file" -g "$region"
	notify_finish
}

recorddesktopwithaudio () {
	wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file"  --audio --audio-backend pulse -g "$(slurp -o)" --audio-device $(pactl list short sources | grep "$(pactl get-default-sink)" | awk '{print $2}')
	notify_finish
}

recordareawithaudio () {
    wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file" --audio --audio-backend pulse -g "$(slurp -d)" --audio-device $(pactl list short sources | grep "$(pactl get-default-sink)" | awk '{print $2}')
	notify_finish
}

recordwinwithaudio () {
    #region=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"' | slurp)
	region=$(hyprctl clients -j | jq -r --arg ws "$(hyprctl activeworkspace -j | jq -r '.id')" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -r)
	wl-screenrec --codec auto --dri-device /dev/dri/renderD128 -f "$dir/$file" --audio --audio-backend pulse -g "$region" --audio-device $(pactl list short sources | grep "$(pactl get-default-sink)" | awk '{print $2}')
	notify_finish
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		recorddesktop
	elif [[ "$1" == '--opt2' ]]; then
		recordarea
	elif [[ "$1" == '--opt3' ]]; then
		recordwin
	elif [[ "$1" == '--opt4' ]]; then
		recorddesktopwithaudio
	elif [[ "$1" == '--opt5' ]]; then
		recordareawithaudio
    elif [[ "$1" == '--opt6' ]]; then
		recordwinwithaudio
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac


