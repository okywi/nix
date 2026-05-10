import requests as r
import json
import os
import sys

CLIENT_ID = "kkal61sp3sfeqr891nzti0fsonmftr"
CLIENT_SECRET = "8izv62x2kn7mqlosrkarbhuh6pej6j"

# Get OAuth Token
TOKEN_URL = 'https://id.twitch.tv/oauth2/token'

params = {
    'client_id': CLIENT_ID,
    'client_secret': CLIENT_SECRET,
    'grant_type': 'client_credentials'
}

response = r.post(TOKEN_URL, params=params)

if response.status_code == 200:
    token_data = response.json()
    access_token = token_data['access_token']
else:
    exit()

streams = [["dekarldent", "☭", "#ff0000"],
        ["marqqusi", "⚒", "#8a45d9"],
        ["krassthema", "","#00ff00"],
        ["banniuwu", "✿", "#F5C2E7"],
        ["naitan", "∩", "#ffffff"],
        ["kil0minati", "", "#00ff00"],
        ["LocoLea", "♥", "#78B159"],
        ["Schubladentrollin", "", "#C74310"],
        ["BastiGHG", "", "#5CA8F3"],
        ["komsijabosna", "★", "#EC2E1F"]]

new_streamers = []

payload = {
    'Client-ID': CLIENT_ID,
    'Authorization': f'Bearer {access_token}'
}

for streamer in streams:
    response = r.get(f"https://api.twitch.tv/helix/streams?user_login={streamer[0]}", headers=payload)
    data = json.loads(response.text)["data"]

    if data:
        title = data[0]["title"]
        streamer_info = {"name":streamer[0], "icon":streamer[1], "color":streamer[2]}
        new_streamers.append(streamer_info)

# read old file
old_streamers = []
streamer_file_path = "/tmp/streamers"
if os.path.exists(streamer_file_path):
    with open(streamer_file_path, 'r') as f:
        content = f.read().strip()
        #print(content)
        if os.path.getsize(streamer_file_path) != 0 and content != "":
            old_streamers = json.loads(content)

#print(old_streamers)
# get difference
for new_streamer in new_streamers:
    inside_old = False
    for old_streamer in old_streamers:
        #print(new_streamer["name"] + old_streamer["name"])
        if new_streamer["name"] == old_streamer["name"]:
            inside_old = True
    print(inside_old)
           
    if not inside_old:
        command = f'user_action=$(notify-send --action=twitch="Open Twitch" "{new_streamer["icon"]} {new_streamer["name"]}" "is now online"  -u critical -i /home/okywi/.config/eww/assets/twitch.png); if [[ $user_action == "twitch" ]]; then xdg-open "https://twitch.tv/{new_streamer["name"]}"; fi'
        os.system(command)

with open(streamer_file_path, "w") as f:
    line = json.dumps(new_streamers).strip() + "\n"
    sys.stdout.write(line)  # Print to console
    f.write(line)