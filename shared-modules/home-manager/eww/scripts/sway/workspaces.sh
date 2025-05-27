icons=("" "" "" "" "" "" "" "" "" "")

get_workspaces_info() {
    local output=$1
    local ws_start ws_length

    if [[ $output == "DP-3" ]]; then
        ws_start=1 ws_length=6
    elif [[ $output == "HDMI-A-1" ]]; then
        ws_start=7 ws_length=4
    elif [[ $output == "eDP-1" ]]; then
        ws_start=1 ws_length=10
    fi

    local names=$(swaymsg -t get_workspaces | jq -r --arg o "$output" '.[] | select(.output == $o) | .name')
    local focused=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused == true) | .name')
    local workspaces=()

    for ((i = ws_start; i < ws_start + ws_length; i++)); do
        local isFocused=$([[ $focused == $i ]] && echo "true" || echo "false")
        local occupied=$([[ $names == *"$i"* ]] && echo "true" || echo "false")

        workspaces+=("$(jq -n \
            --arg id "$i" \
            --arg icon "${icons[i - 1]}" \
            --arg occupied "$occupied" \
            --arg isFocused "$isFocused" \
            '{id: ($id | tonumber), icon: $icon, occupied: $occupied, isFocused: $isFocused}')")
    done

    echo $(printf '%s\n' "${workspaces[@]}" | jq -r . | jq -s)
}

get_workspaces_info "$1"

swaymsg -t subscribe '["workspace"]' --monitor | {
    while read -r; do
        get_workspaces_info "$1"
    done
}