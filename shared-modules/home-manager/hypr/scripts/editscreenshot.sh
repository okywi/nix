if wl-paste --list | grep -q "image/"; then
  wl-paste -t image/png > /tmp/clipboard-image.png
  echo $1
  if [[ "$1" == "--pinta" ]]; then
    pinta /tmp/clipboard-image.png
  elif [[ "$1" == "--satty" ]]; then
    satty --filename /tmp/clipboard-image.png
  fi
else
  notify-send "Clipboard Error" "No image found in clipboard."
fi

