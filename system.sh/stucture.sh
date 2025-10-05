#!/usr/bin/bash

# this file is made for stucturing you home directory ! (~)

echo "making you home directory stuctable"

echo "please enter the full path for the directory"
echo "making a specific directory private"
read -p "place the path of the directory" directory
#ead -p "name of the directory" name
# making the command
mkdir $directory
