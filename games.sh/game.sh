#!/usr/bin/bash

target=$((RANDOM % 100 + 1))
echo "Guess a number between 1 and 100"

while true; do
  read -p "Enter your guess: " guess
  if [[ ! $guess =~ ^[0-9]+$ ]]; then
    echo "Please enter a valid number."
    continue
  fi
  if ((guess < target)); then
    echo "Too low!"
  elif ((guess > target)); then
    echo "Too high!"
  else
    echo "Congratulations! You guessed it!"
    break
  fi
done
