#!/bin/sh

cd "$HOME"/.password-store || exit 0
pass_entries=$(find ./* -type f | cut -c 3- | awk -F ".gpg" '{print $1}')

if [ "$1" = "--both" ]; then

  window_id_msg=$(xprop -root _NET_ACTIVE_WINDOW)
  window_id=$(echo "$window_id_msg" | awk '{print $NF}')
  window_name_msg=$(xprop -id "$window_id" _NET_WM_NAME)
  browser=$(echo "$window_name_msg" | sed 's/"//g' | awk '{print $NF}')

  if [ "$browser" != "Brave" ]; then
    # xdotool command won't work without the little delay
    sleep 0.1
    # in case the site automatically clicks on the user/email input field
    xdotool key Escape
  fi

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
    notify-send -t 1000 "Script failed" && exit 0
  fi

else

  pass_entry=$(echo "$pass_entries" | rofi -dmenu -i -p "pass") || exit 0
  xdotool type "$(pass show "$pass_entry")"

fi

