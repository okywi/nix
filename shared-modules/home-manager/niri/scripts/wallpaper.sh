if which linux-wallpaperengine >/dev/null 2>&1; then
    pkill linux-wallpaperengine 2>/dev/null; linux-wallpaperengine --screen-root DP-3 --screen-root HDMI-A-1 --fps 30 --no-audio-processing --no-fullscreen-pause 1897834524
elif which mpvpaper >/dev/null 2>&1; then
    pkill mpvpaper 2>/dev/null; mpvpaper --auto-pause -o "--loop --no-audio" "*" ~/Pictures/Animated_Wallpapers/aesthetic-cassette-FHD.mp4
else
    pkill swww 2>/dev/null
    swww-daemon &
    sleep 0.5
    swww img ~/.wallpapers/girlmoonearth.jpg
fi