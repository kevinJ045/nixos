#!/usr/bin/env sh

WIDTH=300
HEIGHT=200

# Detect compositor and set position
if pgrep -x Hyprland >/dev/null; then
    # Hyprland: get cursor position
    eval "$(hyprctl -j cursorpos | jq -r '.x as $x | .y as $y | "X=\($x) Y=\($y)"')"
elif pgrep -x sway >/dev/null; then
    # Sway: center on focused output
    eval "$(swaymsg -t get_outputs -r | jq -r '
      .[] | select(.focused) |
      "SCREEN_WIDTH=\(.current_mode.width) SCREEN_HEIGHT=\(.current_mode.height)"
    ')"
    X=$(( (SCREEN_WIDTH - WIDTH) / 2 ))
    Y=$(( (SCREEN_HEIGHT - HEIGHT) / 2 ))
elif pgrep -x niri >/dev/null; then
    eval "$(niri msg outputs | awk '
      /Current mode:/ {
        split($3, res, "x");
        print "SCREEN_WIDTH=" res[1] " SCREEN_HEIGHT=" res[2]
        exit
      }
    ')"
    
    # Assume WIDTH and HEIGHT are already defined
    X=$(( (SCREEN_WIDTH - WIDTH) / 2 ))
    Y=$(( (SCREEN_HEIGHT - HEIGHT) / 2 ))
else
    echo "Unsupported compositor"
    exit 1
fi

# Show clipboard menu
cliphist list | wofi --dmenu --x="$X" --y="$Y" --width "$WIDTH" --height "$HEIGHT" | cliphist decode | wl-copy
