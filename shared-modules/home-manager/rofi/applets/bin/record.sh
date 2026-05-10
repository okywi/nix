#!/usr/bin/env bash

if killall wl-screenrec 2>/dev/null || killall pw-record 2>/dev/null; then
    exit
fi

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Record'
mesg="DIR: `xdg-user-dir PICTURES`/Screenrecordings"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='3'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='3'
	win_width='200px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='3'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='3'
	list_row='1'
	win_width='670px'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Record"
	option_2=" Record with audio"
	option_3=" Record only sound"
else
	option_1=" "
	option_2=" "
	option_3=" "
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
	echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# Screenshot
dir="`xdg-user-dir VIDEOS`/Screenrecordings"
if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
fi


notify_finish() {
	notify-send "Finished recording" "$dir/$file" -t 1200 -e
}

run_screenrec() {
	file=$(date +%H:%M:%S_%d-%m-%Y)_screenrecording.mp4
	
	wl-screenrec --codec auto --bitrate "2 MB" --max-fps 60 --dri-device /dev/dri/renderD128 -f "$dir/$file" -g "$1" $2
}

# take shots
record () {
	run_screenrec "$(slurp -o)"
	notify_finish
}

recordwithaudio () {
	run_screenrec "$(slurp -o)" "--audio --audio-backend pulse --audio-device $(pactl list short sources | grep "$(pactl get-default-sink)" | awk '{print $2}'))"
	notify_finish
}

recordonlyaudio() {
	file=$(date +%H:%M:%S_%d-%m-%Y)_audiorecording.mp3
	pw-record -P '{ stream.capture.sink=true }' "$dir/$file"
	notify_finish
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		record
	elif [[ "$1" == '--opt2' ]]; then
		recordwithaudio
	elif [[ "$1" == '--opt3' ]]; then
		recordonlyaudio
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
esac


