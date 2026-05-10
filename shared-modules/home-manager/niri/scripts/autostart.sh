## Tools
wlsunset -t 3000 -T 3500 &
~/.config/niri/scripts/wallpaper.sh &
~/.config/eww/launch_eww.sh &

## Apps
steam &
sleep 1
dex /usr/share/applications/spotify.desktop &
sleep 5
zapzap &
sleep 3
signal-desktop &
sleep 3
electron-mail &
sleep 5
blueman-applet &
sleep 1
killall swaync; swaync &
niri msg action focus-workspace 1
exit