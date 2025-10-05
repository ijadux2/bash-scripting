#!/bin/bash

echo "Enter first number:"
read num1

echo "Enter second number:"
read num2

echo "Choose operation:"
echo "1) Addition (+)"
echo "2) Subtraction (-)"
echo "3) Multiplication (*)"
echo "4) Division (/)"
read op

case $op in
  1)
    result=$(echo "$num1 + $num2" | bc)
    ;;
  2)
    result=$(echo "$num1 - $num2" | bc)
    ;;
  3)
    result=$(echo "$num1 * $num2" | bc)
    ;;
  4)
    # division with 2 decimal places
    result=$(echo "scale=2; $num1 / $num2" | bc)
    ;;
  *)
    echo "Invalid operation selected"
    exit 1
    ;;
esac

echo "Result: $result"

