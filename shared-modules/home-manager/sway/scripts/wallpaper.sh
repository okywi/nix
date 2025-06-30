if which linux-wallpaperengine >/dev/null 2>&1; then
    pkill linux-wallpaper 2>/dev/null; linux-wallpaperengine --screen-root DP-3 --screen-root HDMI-A-1 --fps 30 --no-audio-processing --no-fullscreen-pause 1897834524
elif which mpvpaper >/dev/null 2>&1; then
    pkill mpvpaper 2>/dev/null; mpvpaper -o "--loop --no-audio" "*" ~/Pictures/Wallpapers/Animated/suzume.mp4
else
    pkill swww 2>/dev/null && swww-daemon &
    sleep 0.5
    swww img ~/.wallpapers/girlmoonearth.jpg
fi
