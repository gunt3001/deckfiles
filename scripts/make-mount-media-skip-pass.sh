#!/bin/bash

# Path to the sudoers file
SUDOERS_FILE="/etc/sudoers"
TEMP_SUDOERS_FILE="/etc/sudoers.tmp"

# Backup the original sudoers file
cp $SUDOERS_FILE "$SUDOERS_FILE.bak"

# Append the new rule to the temporary sudoers file
echo 'deck ALL=(ALL) NOPASSWD: /home/deck/Desktop/deckfiles/scripts/mount-media-sudo.sh' >> $TEMP_SUDOERS_FILE

# Check for syntax errors
visudo -c -f $TEMP_SUDOERS_FILE
if [ $? -eq 0 ]; then
    # If the syntax is OK, move the temporary file to the original
    mv $TEMP_SUDOERS_FILE $SUDOERS_FILE
    echo "Sudoers file updated successfully."
else
    echo "Error detected in sudoers file syntax. No changes were made."
fi
