#!/bin/bash

# Prompt the user for their sudo password
sudo -v

# Enable passwordless sudo for the macbuild run
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

# Install Homebrew
if ! which brew > /dev/null 2>&1
then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
    echo "Copy any installers you have to /Library/Caches/Homebrew and press any key to continue..."
    read -r
fi

# Install Python
if ! brew list ansible > /dev/null 2>&1
then
    echo "Installing Ansible"
    brew install ansible
fi

# Install biplist to allow manipulation of plist files
if ! pip2 show biplist > /dev/null 2>&1
then
    echo "Installing biplist"
    pip2 install biplist
fi

# Perform the build
#ansible-playbook -i localhost, local.yml

# Set Terminal settings
./terminal.js

# Disable passwordless sudo after the macbuild is complete
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) ALL/" /etc/sudoers
