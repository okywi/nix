import requests as r
import json

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
        ["BastiGHG", "", "#5CA8F3"]]

output = []

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
        output.append(streamer_info)

if output == []:
    print([])
else:
    print(json.dumps(output))