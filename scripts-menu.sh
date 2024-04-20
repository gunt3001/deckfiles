#!/bin/bash

# Define the directory containing the scripts
script_dir=~/Desktop/deckfiles/scripts/

# Check if the directory exists
if [ ! -d "$script_dir" ]; then
    zenity --error --text="The directory $script_dir does not exist."
    exit 1
fi

# Generate the list of files for the Zenity radio list
file_list=()
cd "$script_dir"
for script in *.sh; do
    if [ -f "$script" ]; then
        file_list+=("FALSE")
        file_list+=("$script")
        file_list+=("$script") # Description same as filename
    fi
done

# Display the Zenity dialog and capture the selection
selected_script=$(zenity --list --radiolist \
                          --title="Select a script to run" \
                          --width=1280 \
                          --height=800 \
                          --text="Choose a script from the list:" \
                          --column="Select" \
                          --column="Script Name" \
                          --column="Description" \
                          "${file_list[@]}")

# Check if a script was selected
if [ -n "$selected_script" ]; then
    # Execute the selected script using Konsole
    konsole --noclose -e "$script_dir$selected_script"
else
    zenity --info --text="No script was selected."
fi
