#!/bin/bash

# Define the directory containing the scripts
script_dir="$HOME/Desktop/deckfiles/scripts"

# Check if the directory exists
if [ ! -d "$script_dir" ]; then
    whiptail --title "Error" \
             --msgbox "The directory $script_dir does not exist." 8 60
    exit 1
fi

cd "$script_dir" || exit 1

# Generate the list of files for the whiptail menu
options=()
for script in *.sh; do
    if [ -f "$script" ]; then
        # tag, item
        options+=("$script" "$script")
    fi
done

# Check if we actually found any scripts
if [ ${#options[@]} -eq 0 ]; then
    whiptail --title "Info" \
             --msgbox "No .sh scripts were found in $script_dir." 8 60
    exit 0
fi

# Display the whiptail menu and capture the selection
selected_script=$(
    whiptail --title "Select a script to run" \
             --menu "Choose a script from the list:" \
             20 78 10 \
             "${options[@]}" \
             3>&1 1>&2 2>&3
)
exit_status=$?

# If user pressed OK and a script was selected
if [ $exit_status -eq 0 ] && [ -n "$selected_script" ]; then
    # Run the selected script in the current terminal session
    "$script_dir/$selected_script"
    
    # Wait for user to press Enter before closing the terminal
    echo ""
    read -rp "Press Enter to close..."
else
    whiptail --title "Info" \
             --msgbox "No script was selected." 8 40
fi
