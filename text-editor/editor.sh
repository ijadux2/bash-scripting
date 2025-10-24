#!/bin/bash

# Set terminal to raw mode
stty -echo -icanon

# Initialize buffer as array
buffer=("")
cursor_x=0
cursor_y=0

cleanup() {
  stty echo icanon
  clear
  exit
}
trap cleanup INT TERM EXIT

draw() {
  clear
  for line in "${buffer[@]}"; do
    echo "$line"
  done
  tput cup $cursor_y $cursor_x
}

read_key() {
  IFS= read -rsn1 key
  if [[ $key == $'\x1b' ]]; then
    read -rsn2 -t 0.1 rest
    key+=$rest
  fi
  echo "$key"
}

insert_char() {
  local c=$1
  local line="${buffer[$cursor_y]}"
  buffer[$cursor_y]="${line:0:$cursor_x}$c${line:$cursor_x}"
  ((cursor_x++))
}

main_loop() {
  while true; do
    draw
    key=$(read_key)
    case "$key" in
    '') ;;              # ignore
    $'\x03') cleanup ;; # Ctrl-C
    $'\x7f')            # Backspace
      if ((cursor_x > 0)); then
        local line="${buffer[$cursor_y]}"
        buffer[$cursor_y]="${line:0:cursor_x-1}${line:cursor_x}"
        ((cursor_x--))
      fi
      ;;
    $'\x1b[A') # Up arrow
      ((cursor_y > 0)) && ((cursor_y--))
      ;;
    $'\x1b[B') # Down arrow
      ((cursor_y < ${#buffer[@]} - 1)) && ((cursor_y++))
      ;;
    $'\x1b[C') # Right arrow
      ((cursor_x < ${#buffer[$cursor_y]})) && ((cursor_x++))
      ;;
    $'\x1b[D') # Left arrow
      ((cursor_x > 0)) && ((cursor_x--))
      ;;
    *) insert_char "$key" ;;
    esac
  done
}

main_loop
