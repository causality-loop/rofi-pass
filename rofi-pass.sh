#!/bin/sh

cd "$HOME"/.password-store || exit 0
choice=$(find ./* -type f | cut -c 3- | awk -F ".gpg" '{print $1}' | rofi -dmenu -i -p "pass") || exit 0
pass_entry_wc=$(pass show "$choice" | wc -l)

if [ "$pass_entry_wc" -eq 1 ]; then
  xdotool type "$(pass show "$choice")"
else
  user=$(pass show "$choice" | head -n1 )
  pass=$(pass show "$choice" | tail -n1 )
  xdotool type "$user"
  xdotool key Tab
  xdotool type "$pass"
  xdotool key Tab
fi

