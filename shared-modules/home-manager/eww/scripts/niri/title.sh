niri msg -j event-stream | while read -r _; do
    echo $(niri msg -j focused-window | jq -r ".title")
done