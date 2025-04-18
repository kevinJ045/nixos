#!/usr/bin/env sh

eval "$(hyprctl -j cursorpos | jq -r '.x as $x | .y as $y | "export X=\($x) Y=\($y)"')"

cliphist list | wofi --dmenu --x="$X" --y="$Y" --width 300 --height 200 | cliphist decode | wl-copy