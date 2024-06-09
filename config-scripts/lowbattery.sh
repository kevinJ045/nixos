#!/bin/sh

# The battery level threshold for the alert
THRESHOLD=20

# The command to get the battery level percentage
get_battery_level() {
    # You can adjust the path depending on your system's setup
    # This uses the /sys/class/power_supply/BAT0/capacity file to read the battery percentage
    cat /sys/class/power_supply/BAT1/capacity
}

while true; do
    # Get the current battery level
    battery_level=$(get_battery_level)
    
    # Check if the battery level is below the threshold
    if [[ $battery_level -lt $THRESHOLD ]]; then
        # Send a low battery notification
        notify-send --urgency=low --icon=dialog-warning "Low Battery" "Batter is $battery_level%. Plug me nigga."
    fi
    
    # Sleep for a specified time interval (e.g., 5 minutes) before checking again
    sleep 300
done
