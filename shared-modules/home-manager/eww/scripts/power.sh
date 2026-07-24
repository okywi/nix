
if [[ $1 == "--performance" ]] then
    powerprofilesctl set performance
elif [[ $1 == "--balanced" ]]; then
    powerprofilesctl set balanced
elif [[ $1 == "--powersave" ]]; then
    powerprofilesctl set power-saver
fi