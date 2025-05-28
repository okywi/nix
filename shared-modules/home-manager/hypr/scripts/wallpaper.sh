if whereis linux-wallpaperengine >/dev/null 2>&1; then
    pgrep linux-wallpaper || linux-wallpaperengine --screen-root DP-3 --screen-root HDMI-A-1 --fps 30 --no-audio-processing --no-fullscreen-pause 2851658986
else
    hyprpaper
fi