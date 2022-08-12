#!/bin/sh

cd "$HOME"/.password-store || exit 0
pass_entries=$(find ./* -type f | cut -c 3- | awk -F ".gpg" '{print $1}')

if [ "$1" = "--both" ]; then

  # xdotool command won't work without the little delay
  sleep 0.1
  # in case the site automatically clicks on the user/email input field
  xdotool key Escape
  # Vimium binding for URL copy
  xdotool type "yy"
  sleep 0.1
  url=$(xclip -o -sel c)
  url_short=$(echo "$url" | awk -F "//" '{print $NF}' | cut -d "/" -f1)

  for i in $pass_entries
  do
    if [ "$i" = "$url_short" ]; then
      user=$(pass show "$i" | head -n1 )
      pass=$(pass show "$i" | tail -n1 )
      break
    else 
      user=1
      pass=1
    fi
  done

  if [ "$user" != 1 ]; then
    # Vimium binding for focus the first text input on page
    xdotool type "gi"
    xdotool type "$user"
    xdotool key Tab
    xdotool type "$pass"
    xdotool key Tab
  else
    echo "No entries found" && exit 0
  fi

else

  pass_entry=$(echo "$pass_entries" | rofi -dmenu -i -p "pass") || exit 0
  xdotool type "$(pass show "$pass_entry")"

fi

