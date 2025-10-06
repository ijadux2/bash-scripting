#!/usr/bin/bash

echo "Updating the system!"
sleep 1
echo "This might take some time, have a cup of coffee and watch YouTube!"

echo "This action requires sudo password, please enter it when prompted."

# Ask user for update
read -p "Do you want to update the system? (yes/no): " update

# Ask user for upgrade
read -p "Do you want to upgrade the system? (yes/no): " upgrade

# Perform actions based on input
if [[ "$update" == "yes" && "$upgrade" == "yes" ]]; then
    echo "Updating and upgrading the system..."
    sudo apt update && sudo apt upgrade -y
elif [[ "$update" == "yes" ]]; then
    echo "Updating the system..."
    sudo apt update
elif [[ "$upgrade" == "yes" ]]; then
    echo "Upgrading the system..."
    sudo apt upgrade -y
else
    echo "No update or upgrade selected. Exiting."
    exit 0
fi

sleep 2

echo "Done! Your system has been updated."
echo "Have a good day!"
