#!/bin/bash

function loading_spinner() {
  local message=making-file-executable
  local spin_chars='|/-\'
  local i=0

  echo -n "$message"
  chmod +x $HOME/workspace/bash-scripting/cal/*
  #  chmod +x $HOME/workspace/bash-scripting/chatting-app.sh/*
  #  chmod +x $HOME/workspace/bash-scripting/games.sh/*
  chmod +x $HOME/workspace/bash-scripting/system.sh/*
  chmod +x $HOME/workspace/bash-scripting/system.sh/setup.sh/*
  chmod +x $HOME/workspace/bash-scripting/system.sh/system-pkgs/*

  # Hide cursor
  tput civis
  trap "tput cnorm; exit" INT

  while true; do
    printf "\b${spin_chars:i++%${#spin_chars}:1}"
    sleep 0.2
  done
}

# Run spinner in background with & and store PID to stop later
loading_spinner "Loading" &
spinner_pid=$!

# Simulate some work with sleep (replace with your actual task)
sleep 1

# Stop spinner after work done
kill $spinner_pid 2>/dev/null

# Show final message and restore cursor
echo -e "\b Done!"
tput cnorm
