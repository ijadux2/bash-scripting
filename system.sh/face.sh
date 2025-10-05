#!/bin/bash

# Frame 1 - eyes open
frame1='
   .-"""-.
  /       \
 |  o   o  |
 |   \_/   |
  \       /
   `-----`
'

# Frame 2 - eyes closed
frame2='
   .-"""-.
  /       \
 |  -   -  |
 |   \_/   |
  \       /
   `-----`
'

# Infinite loop to animate blinking
while true; do
    clear
    echo "$frame1"
    sleep 0.5
    clear
    echo "$frame2"
    sleep 0.3
done

