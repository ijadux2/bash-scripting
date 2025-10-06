#!/usr/bin/bash

# this app is built on scripting language bash
# the chats are not encripted so use it properly
# using bash as a language for backend and fontend makes this app more larger in file size and a thousnd lines of code !
# enjoy the code and  the app for personal use
#
#
# porpose !
# this app can be used between 2 peoples only
# and for personal use only
# and the chats were not been stored in any extra hidden file
#                                                              -- ijadux2
#!/bin/bash

# Catppuccin Mocha Color Definitions (Truecolor ANSI escapes)
# Base colors for the theme
declare -A colors=(
  ["base"]="\033[48;2;30;30;46m"         # Background: #1e1e2e
  ["mantle"]="\033[48;2;24;24;37m"       # Slightly darker: #181825
  ["crust"]="\033[48;2;17;17;27m"        # Darkest: #11111b
  ["text"]="\033[38;2;205;214;244m"      # Text: #cdd6f4
  ["subtext1"]="\033[38;2;186;194;222m"  # Subtext1: #bac2de
  ["surface0"]="\033[48;2;49;50;68m"     # Surface0: #313244
  ["surface1"]="\033[48;2;69;71;90m"     # Surface1: #45475a
  ["mauve"]="\033[38;2;203;166;247m"     # Mauve accent: #cba6f7
  ["lavender"]="\033[38;2;180;190;254m"  # Lavender: #b4befe
  ["rosewater"]="\033[38;2;245;224;220m" # Rosewater: #f5e0dc
  ["peach"]="\033[38;2;250;179;135m"     # Peach for highlights: #fab387
  ["reset"]="\033[0m"
)

# Function to clear screen with base color
clear_screen() {
  printf "\033[2J\033[H" # Clear screen and home cursor
  printf "${colors[base]}"
  printf "\033[?25l" # Hide cursor for cleaner look
}

# Function to reset colors and show cursor
reset_terminal() {
  printf "${colors[reset]}"
  printf "\033[?25h" # Show cursor
}

# Function to draw a simple designer-style box with colors
draw_box() {
  local width=80
  local height=$1
  local title=$2
  local content="$3"

  # Top border
  printf "${colors[crust]}"
  for ((i = 0; i < width; i++)); do printf "━"; done
  printf "\n"

  # Title line
  local title_padded=$(printf "%*s" $(((width - ${#title} - 4) / 2)) "" | tr ' ' '━')
  printf "${colors[crust]}╭${title_padded} ${colors[mauve]}${title}${colors[crust]} ${title_padded}╮\n"

  # Content lines
  local lines=($(echo "$content" | fold -w $((width - 4)) | sed 's/^/│ /; s/$/ │/'))
  for line in "${lines[@]}"; do
    if [ ${#line} -gt 2 ]; then # Skip empty
      printf "${colors[crust]}${line}\n"
    fi
  done

  # Pad to height if needed
  while [ ${#lines[@]} -lt $((height - 2)) ]; do
    printf "${colors[crust]}│${colors[surface0]}%*s${colors[crust]} │\n" $((width - 4)) ""
    lines+=("")
  done

  # Bottom border
  for ((i = 0; i < width; i++)); do printf "━"; done
  printf "\n${colors[reset]}"
}

# Chat history array (single user, so only user messages)
declare -a chat_history=()

# Function to display chat interface
display_chat() {
  clear_screen
  printf "${colors[base]}"

  # Header box
  local header="Single User Chat App - Catppuccin Mocha"
  draw_box 2 "$header" "Welcome! Type your messages below. Press Ctrl+C to exit."

  printf "\n\n"

  # Chat history box (grow dynamically, max 10 lines for simplicity)
  local history_content=""
  local max_lines=15
  local visible_lines=$((max_lines - 2))
  local history_count=${#chat_history[@]}

  if [ $history_count -gt 0 ]; then
    for ((i = 0; i < history_count; i++)); do
      local msg="${chat_history[$i]}"
      # Timestamp simulation (simple counter)
      local ts="[$((i + 1))]"
      history_content+="${colors[lavender]}${ts}${colors[text]} ${msg}\n"
    done
    # Show last visible_lines messages
    if [ $history_count -gt $visible_lines ]; then
      history_content=$(echo -e "$history_content" | tail -n $visible_lines)
    fi
  else
    history_content="${colors[subtext1]}No messages yet. Start chatting!"
  fi

  draw_box $((visible_lines + 2)) "Chat History" "$history_content"

  printf "\n\n"

  # Prompt box
  local prompt_content="${colors[rosewater]}You: ${colors[text]}"
  draw_box 1 "Message Input" "$prompt_content"

  # Position cursor at end of prompt
  printf "${colors[base]}"
}

# Main loop
trap 'reset_terminal; echo -e "\n${colors[text]}Chat ended. Goodbye!${colors[reset]}\n"; exit 0' INT

echo "Initializing Catppuccin Mocha Chat..."
sleep 1

while true; do
  display_chat

  # Read input (hide echo for input, but we'll show it after)
  read -r -p "" message # Read without prompt echo
  if [ -n "$message" ]; then
    chat_history+=("$message")
    # Limit history to prevent overflow
    if [ ${#chat_history[@]} -gt 50 ]; then
      chat_history=("${chat_history[@]: -50}")
    fi
  fi
done

reset_terminal
