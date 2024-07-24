#!/bin/bash

# Define variables
SUDOERS_FILE="/etc/sudoers.d/~10-deck-media-mount"
BACKUP_FILE="/etc/sudoers.d/~10-deck-media-mount.bak"
TEMP_SUDOERS_FILE="/tmp/temp_sudoers"

# Step 1: Create a backup copy of the file
cp $SUDOERS_FILE $BACKUP_FILE

# Step 2: Create a new temporary file with the desired content
echo "deck ALL=(ALL) NOPASSWD: /home/deck/Desktop/deckfiles/scripts/mount-media.sh" > $TEMP_SUDOERS_FILE

# Step 3: Run visudo to check the syntax of the temporary file
visudo -c -f $TEMP_SUDOERS_FILE

# Step 4: Check the result of visudo
if [ $? -eq 0 ]; then
    # If successful, move the temporary file to the sudoers directory and delete the backup file
    mv $TEMP_SUDOERS_FILE $SUDOERS_FILE
    # Change the permission of the sudoers file to mode 0440
    chmod 0440 $SUDOERS_FILE
    # Delete the backup file
    rm $BACKUP_FILE
    echo "Success: sudoers file updated."
else
    # If failed, delete the temporary file and print a failure message
    rm $TEMP_SUDOERS_FILE
    echo "Failure: sudoers file not updated. Check the syntax and try again."
fi
