#!/bin/bash

CSS_INPUT="./applications/themes/default/assets/css/style.css"
CSS_OUTPUT="./applications/themes/default/assets/css/output.css"

# Create the output directory if it doesn't exist
mkdir -p "$(dirname "$CSS_OUTPUT")"

while true; do
    # Wait for a modification on the file
    inotifywait -e modify "$CSS_INPUT"
    
    # Recompile Tailwind
    npx tailwindcss -i "$CSS_INPUT" -o "$CSS_OUTPUT"
    
    echo "[$(date '+%H:%M:%S')] Rebuild completed"
done
