#!/bin/sh

set -eu

xresources="${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources"
scale=$(hyprctl -j monitors | jq -er '([.[] | select(.focused)][0] // .[0]).scale')
dpi=$(awk -v scale="$scale" 'BEGIN { printf "%.0f", 96 * scale }')

sed -i -E "s/^[[:space:]]*Xft\.dpi:.*/Xft.dpi: $dpi/" "$xresources"
xrdb -merge "$xresources"
