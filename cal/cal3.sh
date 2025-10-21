#!/usr/bin/env bash

# Calculator for Linux - Terminal Based

echo ">>> Calculator App"

# Function to check if input is a number
is_number() {
  [[ $1 =~ ^-?[0-9]+$ ]]
}

# Get first number with validation
while true; do
  read -p "Enter the first number >> " num1
  if is_number "$num1"; then
    break
  else
    echo "Invalid input. Please enter a valid number."
  fi
done

# Get second number with validation
while true; do
  read -p "Enter the second number >> " num2
  if is_number "$num2"; then
    break
  else
    echo "Invalid input. Please enter a valid number."
  fi
done

echo ">>> Operations to perform!"
sleep 1
echo "Available operations: +, -, *, /, square, cube"
read -p "Choose an operation >> " op

# Perform the operation
case $op in
+)
  result=$((num1 + num2))
  echo ">>> $num1 + $num2 = $result"
  ;;
-)
  result=$((num1 - num2))
  echo ">>> $num1 - $num2 = $result"
  ;;
\*)
  result=$((num1 * num2))
  echo ">>> $num1 * $num2 = $result"
  ;;
/)
  if [[ $num2 -eq 0 ]]; then
    echo ">>> Error: Division by zero is not allowed."
  else
    result=$((num1 / num2)) # Integer division; use bc for floats if needed
    echo ">>> $num1 / $num2 = $result"
  fi
  ;;
square)
  read -p "Square which number? (1 for first, 2 for second) >> " choice
  if [[ $choice == 1 ]]; then
    result=$((num1 * num1))
    echo ">>> $num1 squared = $result"
  elif [[ $choice == 2 ]]; then
    result=$((num2 * num2))
    echo ">>> $num2 squared = $result"
  else
    echo "Invalid choice. Defaulting to first number."
    result=$((num1 * num1))
    echo ">>> $num1 squared = $result"
  fi
  ;;
cube)
  read -p "Cube which number? (1 for first, 2 for second) >> " choice
  if [[ $choice == 1 ]]; then
    result=$((num1 * num1 * num1))
    echo ">>> $num1 cubed = $result"
  elif [[ $choice == 2 ]]; then
    result=$((num2 * num2 * num2))
    echo ">>> $num2 cubed = $result"
  else
    echo "Invalid choice. Defaulting to first number."
    result=$((num1 * num1 * num1))
    echo ">>> $num1 cubed = $result"
  fi
  ;;
*)
  echo ">>> Invalid operation. Please choose from +, -, *, /, square, or cube."
  ;;
esac

echo ">>> Calculator session ended."
