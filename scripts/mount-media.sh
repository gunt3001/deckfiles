#!/bin/bash

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
        echo "The share '$share' is already mounted at $mount_point."
    else
        echo "Mounting the share '$share'..."
        mount -t cifs "//${server}/${share}" "$mount_point" -o username="$username",password="$password",rw
        if [ $? -eq 0 ]; then
            echo "Mount of '$share' successful."
        else
            echo "Failed to mount the share '$share'."
        fi
    fi
}

# Server IP
server="192.168.1.12"

# Mount settings for Anime
anime_share="Anime"
anime_mount="/mnt/anime"
anime_user="gunsmb"
anime_pass=""

# Mount settings for Entertainment
ent_share="Entertainment"
ent_mount="/mnt/entertainment"
ent_user="gunsmb"
ent_pass=""

# Mount the Anime share
mount_smb_share "$server" "$anime_share" "$anime_mount" "$anime_user" "$anime_pass"

# Mount the Entertainment share
mount_smb_share "$server" "$ent_share" "$ent_mount" "$ent_user" "$ent_pass"
