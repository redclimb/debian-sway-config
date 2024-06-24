#!/usr/bin/env bash

##############  DEBIAN DISTRIBUTION ################

releasename=`lsb_release -c | awk '{print $2}'`

sudo apt update && sudo apt upgrade -y 
sudo apt install lsb-release -y


## Add repo backports, change source according to your location ##
echo -e "\033[1;35m Adding repo backports... \033[0m\n"

sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
echo "deb http://ftp.it.debian.org/debian/ ${releasename}-backports main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list


## Install packages ##
echo -e "\033[1;35m Installing essential packages... \033[0m\n"

# Utilities
sudo apt install dstat btop firefox-esr fzf nmap vim mousepad atril -y

# Backup
sudo apt install dar rclone -y

# Container
sudo apt install podman podman-compose distrobox -y

# Batcat
sudo apt install bat -y
if [ ! -d $HOME/.local/bin ]; then
    mkdir $HOME/.local/bin
fi
ln -s /usr/bin/batcat $HOME/.local/bin/bat

## Additional packages ##
read -p $'\033[1;35m Insert additional packages you want to install separated by a space, otherwise press enter: \033[0m' packages_list
sudo apt install $packages_list -y


## Press Ctrl+Alt+F8 to get a quick overview of critical errors on the system ##
echo -e "\033[1;35m Configuring journal service... \033[0m\n"

cat << EOF >> $HOME/journal-tty8.service
[Unit]
Description=Journalctl on tty8

[Service]
ExecStart=/usr/bin/journalctl -f -p err
StandardOutput=tty
TTYPath=/dev/tty8
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/journal-tty8.service /etc/systemd/system/journal-tty8.service && sudo systemctl daemon-reload && sudo systemctl enable --now journal-tty8.service


#######################
### OPTIONAL PACKAGES
#######################
# → RUST
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# → BROOT FILE-MANAGER
# sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
# curl -o broot -L https://dystroy.org/broot/download/x86_64-linux/broot
# sudo mv broot /usr/local/bin
# sudo chmod +x /usr/local/bin/broot

# → FLATPAK
# sudo apt install flatpak -y
# flatpak remote-add --if-not-exists --subset=verified flathub-verified https://flathub.org/repo/flathub.flatpakrepo

# Superfile FM (need to install nerd-font - https://www.nerdfonts.com/ -, not provided here)
echo -e "\033[1;35m Installing Superfile FM... \033[0m\n"
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

## Cleaning ##
echo -e "\033[1;35m Cleaning... \033[0m\n"

pacchetti=()

echo -e "\033[1;35m Add packages you want to remove one per line. When you finished, digit 'end' \033[0m"

while :
do
    read pacchetto
    if [ "$pacchetto" == "end" ]; then
        break
    fi
    pacchetti+=($pacchetto)
done

for pacchetto in "${pacchetti[@]}"
do
    # Check if the package is installed
    if dpkg --get-selections | grep -q "^$pacchetto[[:space:]]*install$"; then
        echo -e "\033[0;35m Removing $pacchetto \033[0m"
        sudo apt remove --purge -y $pacchetto
    else
        echo -e "\033[0;35m $pacchetto is not installed \033[0m"
    fi
done

sudo apt autoremove && sudo apt autoclean -y




