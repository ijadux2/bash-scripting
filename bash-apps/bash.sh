#!/bin/bash
TODO_FILE="tasks.txt"

if [ "$1" == "add" ]; then
  echo "$2" >>"$TODO_FILE"
  echo "Task added: $2"
elif [ "$1" == "list" ]; then
  if [ -f "$TODO_FILE" ]; then
    cat "$TODO_FILE"
  else
    echo "No tasks yet."
  fi
else
  echo "Usage: $0 add 'task' or $0 list"
fi
