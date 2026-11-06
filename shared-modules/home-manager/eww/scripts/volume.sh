playerctl volume --player=$player --follow | while read -r volume; do
    echo $volume | awk '{print $1*100}'
done