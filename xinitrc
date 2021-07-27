#!/bin/sh

# packages: gnome-keyring feh unclutter openbox xrdb

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

feh --bg-fill --no-fehbg ~/.config/wall.png &
xrdb $HOME/.config/Xresources
$HOME/.config/bar.sh &
unclutter &

# chad wm
exec openbox
