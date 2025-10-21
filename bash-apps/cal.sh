#!/usr/bin/bash

echo "calculator for bash"

read -p "enter the 1st no >>> " num1
read -p "enter the 2nd no >>> " num2

echo "define operation!"
read -p ">> operations (+,-,*,/)" op

echo "$(($num1$op$num2)) is the result "
