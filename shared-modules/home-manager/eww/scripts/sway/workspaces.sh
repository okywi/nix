input_workspaces


workspaces() {
    workspaces=$(echo "$(swaymsg -t get_workspaces -r)" | jq -s '.[] | flatten | sort_by(.num) | group_by(.output) | map({name: .[0].output, workspaces: .}) | flatten')
    
    echo "$icons" | jq -c --argjson workspaces "$workspaces" '
    def is_occupied($output_index; $num):
        any($workspaces[$output_index].workspaces[]; .num == $num);

    def is_focused($output_index; $num):
        if any($workspaces[$output_index].workspaces[]; .num == $num) then
            ($workspaces[$output_index].workspaces[] | select(.num == $num) | .focused)
        else
            false
        end;

    def get_class($focused; $occupied):
        if $focused then
            " workspace-focused"
        elif $occupied then
            " workspace-occupied"
        else
            ""
        end;

    . | to_entries | map(
        .key as $output_index |
        .value | to_entries | map(
            .value[0] as $icon_id |
            .value[1] as $icon |
            ($icon_id) as $ws_num |
            is_occupied($output_index; $ws_num) as $occupied |
            is_focused($output_index; $ws_num) as $focused |
            {
                num: $ws_num,
                icon: $icon,
                occupied: $occupied,
                focused: $focused,
                class: ("w" + ($ws_num|tostring) + " workspace-button" + get_class($focused; $occupied))
            }
        )
    )'
}
# run once then subscribe
workspaces

swaymsg -t subscribe '["workspace"]' --monitor | while read -r _; do
    workspaces 
done
