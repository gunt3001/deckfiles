#!/bin/bash

# Variables
SUBTREE_PREFIX="config/mpv/scripts/file-browser"   # The directory where the subtree is located
REPO_URL="https://github.com/CogentRedTester/mpv-file-browser.git"  # The URL of the external repository
BRANCH="master"  # The branch you want to pull changes from

cd ../../.. # Go back to git root

# Check if the current directory is correct
if [ ! -d "$SUBTREE_PREFIX" ]; then
    echo "Error: Directory $SUBTREE_PREFIX does not exist. Please ensure you are in the correct directory."
    exit 1
fi

# Pull the latest changes from the subtree
echo "Pulling latest changes from $REPO_URL ($BRANCH) into $SUBTREE_PREFIX..."
git subtree pull --prefix="$SUBTREE_PREFIX" "$REPO_URL" "$BRANCH" --squash

# Check if the pull was successful
if [ $? -eq 0 ]; then
    echo "Successfully pulled changes into $SUBTREE_PREFIX."
else
    echo "Error: Failed to pull changes from the subtree."
    exit 1
fi

