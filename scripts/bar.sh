#!/bin/sh

i3status | while :
do
	read line
	echo "%{c}${line}" || exit 1
done | lemonbar -o DP-0 \
	-B "#222" \
	-f "-misc-tamsyn-*-*-*-*-12-*-*-*-*-*-*-*"
