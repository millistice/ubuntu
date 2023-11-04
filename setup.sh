#!/bin/sh

# This script is what I use on all my new #
# Ubuntu installations to save time when #
# setting them up for the first time #

## TODO ##
### HIGH PRIORITY ###
## Automate the removal of netplan ##
## Add irqbalance automatic setup ##
## Add fail2ban automatic setup for ufw ##
### MEDIUM PRIORITY ###
## Bypass ufw requiring input to enable (-y doesn't seem to work)
### LOW PRIORITY ###
##                ##

# Print initialization message
echo Now setting up your system

# Update and upgrades existing packages
sudo apt update 
sudo apt upgrade -y
sudo apt autoclean

# Remove ifupdown2
sudo apt remove ifupdown2 -y

# Install the original ifupdown
sudo apt install ifupdown -y

# Install the preload daemon
sudo apt install preload -y

# Install irqbalance (requires manual setup, see TODO)
sudo apt install irqbalance -y

# Install net-tools
sudo apt install net-tools -y

# Install mtr
sudo apt install mtr -y

# Install netfilter-persistent
sudo apt install netfilter-persistent -y
sudo apt install iptables-persistent -y
sudo apt install ipset-persistent -y

# Flush netfilter-persistent
sudo netfilter-persistent flush

# Install fail2ban (needs manual installation, see TODO)
sudo apt install fail2ban -y

# Remove systemd-resolved
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm /etc/resolv.conf

# Restore original resolv.conf
sudo wget -q -O /etc/resolv.conf https://raw.githubusercontent.com/millistice/ubuntu/main/files/resolv.conf

# Install ufw
sudo apt install ufw -y
## Prevent Censys data collection
sudo ufw deny from 162.142.125.0/24
sudo ufw deny from 167.94.138.0/24
sudo ufw deny from 167.94.145.0/24
sudo ufw deny from 167.94.146.0/24
sudo ufw deny from 167.248.133.0/24
sudo ufw deny from 199.45.154.0/24
sudo ufw deny from 199.45.155.0/24
sudo ufw deny from 2602:80d:1000:b0cc:e::/80
sudo ufw deny from 2620:96:e000:b0cc:e::/80
## Ratelimit OpenSSH
sudo ufw limit ssh
## Enable ufw (requires manual input, see TODO)
sudo ufw enable 
## Reload ufw
sudo ufw reload

# Print a message indicating completion and impending reboot
sudo echo Now restarting your system

# Reboot the system
sudo reboot now
