#!/bin/sh

#
# changes volume with a visual cue
#

# arguments are passed to pamixer
pamixer "$@"

# pipe gaming
pamixer --get-volume | dbar | dzen2 -p 1 \
	-x 40 -y 40 -w 400 \
	-fn "Misc Tamsyn:pixelsize=24"
