#!/bin/bash

# Define the file path
FILE="$HOME/Desktop/hello_world.txt"

# Get the current date and time
NOW=$(date +"%Y-%m-%d %H:%M:%S")

# Create the file and add the text "Hello, World!" with the current date and time
echo "Hello, World! This file was created on $NOW" > "$FILE"

# Inform the user
echo "The file 'hello_world.txt' has been created on your Desktop."
