#!/bin/bash

# Set terminal to raw mode
stty -echo -icanon

# Initialize buffer as array
buffer=("")
cursor_x=0
cursor_y=0
tab_size=4

# Mode system
MODE_NORMAL="NORMAL"
MODE_INSERT="INSERT" 
MODE_VISUAL="VISUAL"
MODE_COMMAND="COMMAND"
current_mode="$MODE_NORMAL"

# Command buffer for multi-key commands
command_buffer=""
register=""

# File info
filename=""
modified=false

cleanup() {
  stty echo icanon
  clear
  exit
}
trap cleanup INT TERM EXIT

draw() {
  clear
  local term_height=$(tput lines)
  local term_width=$(tput cols)
  local status_line=$((term_height - 2))
  
  # Draw content area
  local i=0
  for ((i=0; i<term_height-2 && i<${#buffer[@]}; i++)); do
    if [[ $current_mode == "$MODE_VISUAL" && $i -ge ${visual_start:-0} && $i -le $cursor_y ]]; then
      tput setab 7  # Highlight visual selection
      tput setaf 0
    fi
    printf "%3d: %s" $((i + 1)) "${buffer[$i]}"
    if [[ $current_mode == "$MODE_VISUAL" && $i -ge ${visual_start:-0} && $i -le $cursor_y ]]; then
      tput sgr0  # Reset colors
    fi
    printf "\n"
  done
  
  # Fill remaining lines
  for ((i=${#buffer[@]}; i<term_height-2; i++)); do
    printf "~\n"
  done
  
  # Status bar
  tput cup $status_line 0
  tput setab 4
  tput setaf 7
  local status_info="$current_mode"
  [[ $modified == true ]] && status_info+=" [+]"
  [[ -n $filename ]] && status_info+=" $filename"
  status_info+=" | Line $((cursor_y + 1)), Col $((cursor_x + 1))"
  printf "%-*s" $term_width "$status_info"
  tput sgr0
  
  # Command line
  tput cup $((term_height - 1)) 0
  if [[ $current_mode == "$MODE_COMMAND" ]]; then
    printf ":$command_buffer"
  else
    printf ""
  fi
  
  # Position cursor
  if [[ $current_mode != "$MODE_COMMAND" ]]; then
    tput cup $cursor_y $((cursor_x + 5))
  else
    tput cup $((term_height - 1)) $((2 + ${#command_buffer}))
  fi
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
  modified=true
}

delete_char() {
  if ((cursor_x < ${#buffer[$cursor_y]})); then
    local line="${buffer[$cursor_y]}"
    buffer[$cursor_y]="${line:0:$cursor_x}${line:$((cursor_x + 1))}"
    modified=true
  fi
}

delete_line() {
  if ((cursor_y < ${#buffer[@]})); then
    buffer=("${buffer[@]:0:$cursor_y}" "${buffer[@]:$((cursor_y + 1))}")
    if ((cursor_y >= ${#buffer[@]} && ${#buffer[@]} > 0)); then
      ((cursor_y--))
    fi
    cursor_x=0
    modified=true
  fi
}

yank_line() {
  if ((cursor_y < ${#buffer[@]})); then
    register="${buffer[$cursor_y]}"
  fi
}

paste_line() {
  if [[ -n $register ]]; then
    buffer=("${buffer[@]:0:$((cursor_y + 1))}" "$register" "${buffer[@]:$((cursor_y + 1))}")
    ((cursor_y++))
    cursor_x=0
    modified=true
  fi
}

handle_normal_mode() {
  local key="$1"
  
  case "$key" in
    'i') current_mode="$MODE_INSERT" ;;
    'a') 
      ((cursor_x++))
      current_mode="$MODE_INSERT"
      ;;
    'o')
      buffer=("${buffer[@]:0:$((cursor_y + 1))}" "" "${buffer[@]:$((cursor_y + 1))}")
      ((cursor_y++))
      cursor_x=0
      current_mode="$MODE_INSERT"
      modified=true
      ;;
    'O')
      buffer=("${buffer[@]:0:$cursor_y}" "" "${buffer[@]:$cursor_y}")
      cursor_x=0
      current_mode="$MODE_INSERT"
      modified=true
      ;;
    'h') ((cursor_x > 0)) && ((cursor_x--)) ;;
    'j') 
      if ((cursor_y < ${#buffer[@]} - 1)); then
        ((cursor_y++))
        local line_len=${#buffer[$cursor_y]}
        ((cursor_x > line_len)) && cursor_x=$line_len
      fi
      ;;
    'k') 
      if ((cursor_y > 0)); then
        ((cursor_y--))
        local line_len=${#buffer[$cursor_y]}
        ((cursor_x > line_len)) && cursor_x=$line_len
      fi
      ;;
    'l') ((cursor_x < ${#buffer[$cursor_y]})) && ((cursor_x++)) ;;
    '0') cursor_x=0 ;;
    '$') cursor_x=${#buffer[$cursor_y]} ;;
    'x') delete_char ;;
    'dd') delete_line ;;
    'yy') yank_line ;;
    'p') paste_line ;;
    'G') cursor_y=$((${#buffer[@]} - 1)) ;;
    'g') 
      if [[ $command_buffer == "g" ]]; then
        cursor_y=0
        command_buffer=""
      else
        command_buffer="g"
      fi
      ;;
    'v') 
      current_mode="$MODE_VISUAL"
      visual_start=$cursor_y
      ;;
    ':') 
      current_mode="$MODE_COMMAND"
      command_buffer=""
      ;;
    '/') 
      current_mode="$MODE_COMMAND"
      command_buffer="/"
      ;;
    $'\x1b[A') ((cursor_y > 0)) && ((cursor_y--)) ;;
    $'\x1b[B') ((cursor_y < ${#buffer[@]} - 1)) && ((cursor_y++)) ;;
    $'\x1b[C') ((cursor_x < ${#buffer[$cursor_y]})) && ((cursor_x++)) ;;
    $'\x1b[D') ((cursor_x > 0)) && ((cursor_x--)) ;;
  esac
}

handle_insert_mode() {
  local key="$1"
  
  case "$key" in
    $'\x1b') current_mode="$MODE_NORMAL" ;;
    $'\x7f')
      if ((cursor_x > 0)); then
        local line="${buffer[$cursor_y]}"
        buffer[$cursor_y]="${line:0:cursor_x-1}${line:cursor_x}"
        ((cursor_x--))
        modified=true
      fi
      ;;
    $'\x0d')
      local line="${buffer[$cursor_y]}"
      local before="${line:0:$cursor_x}"
      local after="${line:$cursor_x}"
      buffer[$cursor_y]="$before"
      buffer=("${buffer[@]:0:$((cursor_y + 1))}" "$after" "${buffer[@]:$((cursor_y + 1))}")
      ((cursor_y++))
      cursor_x=0
      modified=true
      ;;
    $'\x09')
      local spaces=""
      for ((i = 0; i < tab_size; i++)); do
        spaces+=" "
      done
      insert_char "$spaces"
      ;;
    *) insert_char "$key" ;;
  esac
}

handle_command_mode() {
  local key="$1"
  
  case "$key" in
    $'\x1b')
      current_mode="$MODE_NORMAL"
      command_buffer=""
      ;;
    $'\x7f')
      command_buffer="${command_buffer%?}"
      ;;
    $'\x0d')
      execute_command "$command_buffer"
      command_buffer=""
      ;;
    *) command_buffer+="$key" ;;
  esac
}

execute_command() {
  local cmd="$1"
  
  case "$cmd" in
    'q') 
      if [[ $modified == false ]]; then
        cleanup
      else
        command_buffer="No write since last change"
      fi
      ;;
    'q!')
      cleanup
      ;;
    'w')
      if [[ -n $filename ]]; then
        printf "%s\n" "${buffer[@]}" > "$filename"
        modified=false
      else
        command_buffer="No filename"
      fi
      ;;
    'wq')
      if [[ -n $filename ]]; then
        printf "%s\n" "${buffer[@]}" > "$filename"
        cleanup
      else
        command_buffer="No filename"
      fi
      ;;
    'e '*)
      local new_file="${cmd#e }"
      if [[ -f $new_file ]]; then
        mapfile -t buffer < "$new_file"
        filename="$new_file"
        cursor_x=0
        cursor_y=0
        modified=false
      else
        command_buffer="File not found: $new_file"
      fi
      ;;
    '/'*)
      search_pattern="${cmd#/}"
      # Simple search implementation
      for ((i=cursor_y+1; i<${#buffer[@]}; i++)); do
        if [[ "${buffer[$i]}" == *"$search_pattern"* ]]; then
          cursor_y=$i
          cursor_x=0
          break
        fi
      done
      current_mode="$MODE_NORMAL"
      ;;
  esac
}

main_loop() {
  while true; do
    draw
    key=$(read_key)
    
    case "$current_mode" in
      "$MODE_NORMAL") handle_normal_mode "$key" ;;
      "$MODE_INSERT") handle_insert_mode "$key" ;;
      "$MODE_COMMAND") handle_command_mode "$key" ;;
      "$MODE_VISUAL") 
        case "$key" in
          $'\x1b') current_mode="$MODE_NORMAL" ;;
          'j') ((cursor_y < ${#buffer[@]} - 1)) && ((cursor_y++)) ;;
          'k') ((cursor_y > 0)) && ((cursor_y--)) ;;
          'y') 
            # Yank selected lines
            local selected_lines=()
            for ((i=visual_start; i<=cursor_y; i++)); do
              selected_lines+=("${buffer[$i]}")
            done
            register=$(printf "%s\n" "${selected_lines[@]}")
            current_mode="$MODE_NORMAL"
            ;;
          'd')
            # Delete selected lines
            buffer=("${buffer[@]:0:$visual_start}" "${buffer[@]:$((cursor_y + 1))}")
            cursor_y=$visual_start
            cursor_x=0
            modified=true
            current_mode="$MODE_NORMAL"
            ;;
        esac
        ;;
    esac
  done
}

# Handle file argument if provided
if [[ $# -gt 0 ]]; then
  filename="$1"
  if [[ -f $filename ]]; then
    mapfile -t buffer < "$filename"
  else
    buffer=("")
  fi
fi

main_loop
