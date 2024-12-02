#!/bin/bash

flatpak update com.google.Chrome --no-deps --assumeyes --noninteractive
flatpak run com.google.Chrome --kiosk "https://www.netflix.com"
