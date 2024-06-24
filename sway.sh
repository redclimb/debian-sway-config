#!/usr/bin/env bash

## Update cache ##
printf "\033[1;35m Updating cache... \033[0m\n"
sudo apt update && sudo apt upgrade -y

## Environment&Libraries ##
printf "\033[1;35m Installing Env... \033[0m\n"
sudo apt install -y curl build-essential cmake cmake-extras meson ninja-build \
libxcb-util-dev libxkbcommon-dev bison libncurses-dev libelf-dev libcairo2-dev libpango1.0-dev \
libstartup-notification0-dev libdrm-common libwayland-cursor0 gettext flex kanshi

## Sway Wayland ##
printf "\033[1;35m Installing compositor... \033[0m\n"
sudo apt install -y sway waybar swaylock swayidle swayimg swaybg  wdisplays wayland-protocols wayland-utils wlogout \
xdg-desktop-portal-wlr xdg-desktop-portal-dev wlr-randr libwayland-dev libpcre2-dev libjson-c-dev libwlroots-dev

## Multimedia ##
sudo apt install -y mpv mpv-mpris pamixer ffmpeg imv ristretto pipewire pulseaudio pipewire-pulse \
pavucontrol pamixer wireplumber light
sudo apt install -y libdrm-amdgpu1 libpng-dev libavutil-dev libavcodec-dev libavformat-dev

## Tools ##
printf "\033[1;35m Installing Tools... \033[0m\n"
sudo apt install -y dialog mtools tofi avahi-daemon nemo acpi ntfs-3g acpid gvfs cifs-utils grimshot upower network-manager \
efibootmgr libnotify-bin mako-notifier

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

## Printers and Bluetooth ##
# sudo apt install -y cups system-config-printer simple-scan
# sudo apt install -y bluez bluez-tools blueman

# sudo systemctl enable cups
# sudo systemctl enable bluetooth

## Fonts ##
printf "\033[1;35m Installing fonts... \033[0m\n"
sudo apt install -y fonts-recommended fonts-font-awesome fonts-terminus

## Cleaning ##
printf "\033[1;35m Cleaning... \033[0m\n"
sudo apt autoremove && sudo apt autoclean -y

printf "\033[1;32m Please reboot now... \033[0m\n"
