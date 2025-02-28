#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

# To enable the script to be run as a non-root user without a password prompt,
# we modify the sudoers file.
# This should persist across reboots and only need to be done once per SteamOS update.
update_sudoers_file() {
    local sudoers_file="/etc/sudoers.d/10-deck-media-mount"
    local temp_sudoers_file="/tmp/temp_sudoers"

    # Check if the sudoers file already exists
    if [ -f "$sudoers_file" ]; then
        echo "The sudoers file already exists. Skipping..."
        return
    fi
    
    # Create a new temporary file specifying the script path to whitelist
    echo "deck ALL=(ALL) NOPASSWD: /home/deck/Desktop/deckfiles/scripts/mount-media.sh" > "$temp_sudoers_file"
    
    # Run visudo to check the syntax of the temporary file
    visudo -c -f "$temp_sudoers_file"
    
    # Check the result of visudo
    if [ $? -eq 0 ]; then
        # If successful, move the temporary file to the sudoers directory
        mv "$temp_sudoers_file" "$sudoers_file"
        # Change the permission of the sudoers file to mode 0440
        chmod 0440 "$sudoers_file"
        # Change the ownership of the sudoers file to root as required by recent versions of SteamOS
        chown root:root "$sudoers_file"
        echo "Success: sudoers file updated."
    else
        # If failed, delete the temporary file and print a failure message
        rm "$temp_sudoers_file"
        echo "Failure: sudoers file not updated. Check the syntax and try again."
    fi
}

# Define a function to mount a share
mount_smb_share() {
    local server=$1
    local share=$2
    local mount_point=$3
    local username=$4
    local password=$5

    # Check if the mount point directory exists, if not, create it
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi

    # Check if the share is already mounted
    if mountpoint -q "$mount_point"; then
        echo "The share '$share' is already mounted at $mount_point. Unmounting first..."
	umount "$mount_point"
    fi
    echo "Mounting the share '$share'..."
    mount -t cifs "//${server}/${share}" "$mount_point" -o username="$username",password="$password",rw
    if [ $? -eq 0 ]; then
        echo "Mount of '$share' successful."
    else
        echo "Failed to mount the share '$share'."
    fi
}

# Server IP
server="{enter server IP here}"
samba_user="{replace_with_samba_user}"
samba_pass="{replace_with_samba_pass}"

# Mount settings for Anime
anime_share="Anime"
anime_mount="/mnt/anime"

# Mount settings for Entertainment
ent_share="Entertainment"
ent_mount="/mnt/entertainment"

# Update the sudoers file to allow mounting media shares without a password
update_sudoers_file

# Mount the Anime share
mount_smb_share "$server" "$anime_share" "$anime_mount" "$samba_user" "$samba_pass"

# Mount the Entertainment share
mount_smb_share "$server" "$ent_share" "$ent_mount" "$samba_user" "$samba_pass"
