if wl-paste --list | grep -q "image/"; then
  wl-paste >/tmp/clipboard_image.png
  pinta /tmp/clipboard_image.png
else
  notify-send "Clipboard Error" "No image found in clipboard."
fi
