playerctl volume --player=spotify --follow | while read -r volume; do
    # Extract the title of the focused window
    echo $volume | awk '{print $1*100}'
done