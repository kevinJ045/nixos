#!/bin/sh

# Define the file path
SWAY_START_FILE="$HOME/.swaystart"

# Check if the file exists
if [ -f "$SWAY_START_FILE" ]; then
    # Read and execute each line in the file
    while IFS= read -r command; do
        # Execute the command
        eval "$command"
    done < "$SWAY_START_FILE"
    
    # Clear the file
    > "$SWAY_START_FILE"
else
    > "$SWAY_START_FILE"
fi
