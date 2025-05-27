
# ICON CONFIGURATION
declare -A OUTPUT_ICONS=(
    input_workspaces
    # Add more outputs as needed: [2]="icon1 icon2..."
)

# Convert icons to jq-friendly format
get_icons_json() {
    local json="{"
    for idx in "${!OUTPUT_ICONS[@]}"; do
        json+="\"$idx\":\"${OUTPUT_ICONS[$idx]}\","
    done
    json="${json%,}}"
    echo "$json"
}

process_workspaces() {
    local json_data="$1"
    local icons_json
    icons_json=$(get_icons_json)
    local workspace_statuses
    workspace_statuses=$(hyprctl workspaces -j)
    
    echo "$json_data" | jq --argjson statuses "$workspace_statuses" \
        --argjson icons "$icons_json" \
    '
        def get_icon(output_index; workspace_index):
            (($icons | to_entries[] | select(.key == (output_index|tostring)).value | split(" "))[workspace_index]) 
            // (workspace_index + 1 | tostring);
        
        def is_occupied(id):
            ($statuses | .[] | select(.id == id) | .windows > 0);
        
        # Calculate the cumulative offset for each monitor
        def calculate_offsets:
            reduce .[] as $monitor (
                [0];
                . + [.[-1] + ($monitor.workspaces | length)]
            );
        
        . as $root |
        ($root | calculate_offsets) as $offsets |
        reduce range(0; length) as $i (
            $root;
            reduce range(0; .[$i].workspaces | length) as $j (
                .;
                .[$i].workspaces[$j] |= (
                    .name = get_icon($i; $j) |
                    
                    # Use the offset from previous monitors plus current position
                    .occupied = is_occupied($offsets[$i] + $j + 1) |
                    
                    if .occupied then
                        .class += " workspace-occupied"
                    else
                        .
                    end
                )
            )
        )
    '
}

hyprland-workspaces _ | while read -r line; do
    process_workspaces "$line" | jq -c
done