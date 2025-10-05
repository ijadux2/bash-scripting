#!/bin/bash

echo "Choose operation:"
echo "1) Addition (+)"
echo "2) Subtraction (-)"
echo "3) Multiplication (*)"
echo "4) Division (/)"
echo "5) Sine (sin) - Enter angle in degrees"
echo "6) Cosine (cos) - Enter angle in degrees"
echo "7) Tangent (tan) - Enter angle in degrees"
read op

case $op in
  1)
    echo "Enter first number:"
    read num1
    echo "Enter second number:"
    read num2
    result=$(echo "scale=2; $num1 + $num2" | bc -l)
    ;;
  2)
    echo "Enter first number:"
    read num1
    echo "Enter second number:"
    read num2
    result=$(echo "scale=2; $num1 - $num2" | bc -l)
    ;;
  3)
    echo "Enter first number:"
    read num1
    echo "Enter second number:"
    read num2
    result=$(echo "scale=2; $num1 * $num2" | bc -l)
    ;;
  4)
    echo "Enter first number:"
    read num1
    echo "Enter second number:"
    read num2
    result=$(echo "scale=2; $num1 / $num2" | bc -l)
    ;;
  5)
    echo "Enter angle in degrees:"
    read angle
    # Convert degrees to radians: angle * pi / 180
    result=$(echo "scale=4; s($angle * pi / 180)" | bc -l)
    ;;
  6)
    echo "Enter angle in degrees:"
    read angle
    # Convert degrees to radians: angle * pi / 180
    result=$(echo "scale=4; c($angle * pi / 180)" | bc -l)
    ;;
  7)
    echo "Enter angle in degrees:"
    read angle
    # Convert degrees to radians: angle * pi / 180
    result=$(echo "scale=4; t($angle * pi / 180)" | bc -l)
    ;;
  *)
    echo "Invalid operation selected"
    exit 1
    ;;
esac

echo "Result: $result"
