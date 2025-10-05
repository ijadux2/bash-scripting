#!/usr/bin/bash
read -p "hi listing files in any directory" $directory

# functions for listing

lsd -a $directory

sleep 1

# return the function and exit the script !

echo "listed"
