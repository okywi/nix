process_workspaces() {
    spaces=$(niri msg -j workspaces)

    spaces_updated=$(echo "$spaces" | jq -s 'flatten | map(
        if .name == null then .icon = ""
        elif (.name | contains("browser")) then .icon = ""
        elif .name == "gaming" then .icon = ""
        elif .name == "terminal" then .icon = ""
        elif .name == "coding" then .icon = ""
        elif .name == "spotify" then .icon = ""
        elif .name == "chat" then .icon = ""
        else .
        end
        | .class = "ws w-\(.name)"  | 
        if .is_active == true then .class += " ws-active"
        else .
        end |
        if .active_window_id != null then .class += " ws-occupied"
        else .
        end
        ) | sort_by(.id) | group_by(.output) | map({name: .[0].output, workspaces: .}) | flatten'
    )
    echo "$spaces_updated" | jq -c
}

process_workspaces

env --argv0 workspacesScript niri msg -j event-stream | while read -r line; do
    #if [[ $line == *"WorkspaceActivated"* ]]; then
    #   process_workspaces    
    # fi
    process_workspaces
done
