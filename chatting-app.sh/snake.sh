#!/bin/bash

# Simple Snake Game in Bash
# Controls: w/a/s/d to move, q to quit

# Game variables
WIDTH=20
HEIGHT=10
SNAKE=("5,5" "5,4" "5,3")
DIRECTION="RIGHT"
FOOD=""
SCORE=0

# Function to draw the game board
draw() {
  clear
  echo "Score: $SCORE"
  for ((y = 0; y < HEIGHT; y++)); do
    for ((x = 0; x < WIDTH; x++)); do
      pos="$x,$y"
      if [[ " ${SNAKE[*]} " =~ " $pos " ]]; then
        echo -n "O"
      elif [[ "$pos" == "$FOOD" ]]; then
        echo -n "*"
      else
        echo -n "."
      fi
    done
    echo
  done
}

# Function to generate food
generate_food() {
  while true; do
    fx=$((RANDOM % WIDTH))
    fy=$((RANDOM % HEIGHT))
    FOOD="$fx,$fy"
    if [[ ! " ${SNAKE[*]} " =~ " $FOOD " ]]; then
      break
    fi
  done
}

# Function to move snake
move() {
  head=${SNAKE[0]}
  IFS=',' read -r hx hy <<<"$head"
  case $DIRECTION in
  UP) ((hy--)) ;;
  DOWN) ((hy++)) ;;
  LEFT) ((hx--)) ;;
  RIGHT) ((hx++)) ;;
  esac
  new_head="$hx,$hy"

  # Check collision with walls
  if ((hx < 0 || hx >= WIDTH || hy < 0 || hy >= HEIGHT)); then
    echo "Game Over! Hit wall."
    exit 0
  fi

  # Check collision with self
  if [[ " ${SNAKE[*]} " =~ " $new_head " ]]; then
    echo "Game Over! Hit self."
    exit 0
  fi

  SNAKE=("$new_head" "${SNAKE[@]}")

  # Check if food eaten
  if [[ "$new_head" == "$FOOD" ]]; then
    ((SCORE++))
    generate_food
  else
    unset SNAKE[${#SNAKE[@]}-1]
  fi
}

# Main game loop
generate_food
while true; do
  draw
  read -t 0.2 -n1 input
  case $input in
  w) [[ "$DIRECTION" != "DOWN" ]] && DIRECTION="UP" ;;
  s) [[ "$DIRECTION" != "UP" ]] && DIRECTION="DOWN" ;;
  a) [[ "$DIRECTION" != "RIGHT" ]] && DIRECTION="LEFT" ;;
  d) [[ "$DIRECTION" != "LEFT" ]] && DIRECTION="RIGHT" ;;
  q) exit 0 ;;
  esac
  move
done
