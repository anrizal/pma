#!/bin/sh
 
##### INFO #####

# provision.sh
#
# This script will provision a clean Ubuntu 12.04 LTS 64bit Vagrant box to be
# used for drupal 7 development.
# 
# Author: Arradi Nur Rizal

# add puppetlab repository
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb && sudo dpkg -i puppetlabs-release-precise.deb && sudo apt-get update

# install puppet master
sudo apt-get install puppet -y

# change hostname
echo "agent.pma" > /etc/hostname

# update hosts file
echo "127.0.1.1\tagent.pma" >> /etc/hosts
echo "10.0.1.10\tmaster.pma" >> /etc/hosts

#====================================CLEAN UP==================================

# remove obsolete packages
sudo apt-get autoremove -y 

# reboot
sudo reboot

#==================================PROVISION CHECK==============================

# Create .provision_check for the script to check on during a next vargant up.
echo "[provisioning] Creating .provision_done file..."
touch .provision_done