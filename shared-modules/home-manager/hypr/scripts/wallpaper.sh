if which linux-wallpaperengine >/dev/null 2>&1; then
    pkill linux-wallpaper 2>/dev/null; linux-wallpaperengine --screen-root DP-3 --screen-root HDMI-A-1 --fps 30 --no-audio-processing --no-fullscreen-pause 1897834524
else
    pkill hyprpaper 2>/dev/null && hyprpaper
fi
