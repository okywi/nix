niri msg -j event-stream | while read -r _; do
    title=$(niri msg -j focused-window | jq -r ".title")
    if [[ $title == "null" ]]; then
        echo desktop
    else 
        echo $title
    fi
done