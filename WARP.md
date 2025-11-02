# WARP.md
## Project Overview

This repository is a collection of interactive bash scripts organized into functional categories. It serves as a personal utility toolkit with applications, games, system configuration tools, and calculators - all implemented in bash.

## Repository Structure

The codebase is organized into functional modules:

- **`cal/`** - Calculator applications (basic arithmetic and scientific functions)
- **`chatting-app.sh/`** - Single-user chat interface with Catppuccin Mocha theming
- **`games.sh/`** - Simple terminal games (number guessing game)
- **`system.sh/`** - System utilities and configuration scripts
  - **`setup.sh/`** - Development environment setup scripts for different Linux distributions
  - **`system-pkgs/`** - Package management and installation utilities
- **Root level** - Main execution and permission management scripts

## Common Development Commands

### Making Scripts Executable
The repository includes utility scripts to make all bash files executable:

```bash
# Make all scripts in the repository executable
./execute.sh

# Make scripts in system.sh directory executable  
cd system.sh && ./execute.sh
```

### Running Individual Applications

```bash
# Calculator applications
cd cal && ./calculator.sh     # Basic arithmetic calculator
cd cal && ./cal2.sh          # Scientific calculator with trigonometric functions

# Chat application
cd chatting-app.sh && ./chat.sh    # Single-user chat with themed interface

# Games
cd games.sh && ./game.sh     # Number guessing game

# System utilities
cd system.sh && ./face.sh    # Animated ASCII face
cd system.sh && ./stucture.sh # Directory structure creator
```

### System Setup Scripts

```bash
# Ubuntu/Debian development environment setup
cd system.sh/setup.sh && ./setup.sh

# Fedora development environment setup  
cd system.sh/setup.sh && ./fedora-setup.sh

# Install common packages
cd system.sh/system-pkgs && ./pkgs.sh
```

## Architecture Notes

### Script Design Patterns
- **Modular organization**: Each functional area has its own directory
- **Interactive interfaces**: Scripts use `read` commands for user input
- **Error handling**: Input validation and graceful exits
- **Visual feedback**: Loading spinners, colored output, and ASCII art

### Key Implementation Details
- **Color theming**: The chat application implements a complete Catppuccin Mocha color scheme using ANSI escape codes
- **Mathematical operations**: Calculators use `bc` command for precise arithmetic and scientific functions
- **Package management**: Setup scripts support multiple Linux distributions (Ubuntu/Debian via apt, Fedora via dnf)
- **Terminal manipulation**: Uses `tput` for cursor control and terminal formatting

### Dependencies
Scripts rely on common Linux utilities:
- `bc` (calculator functions)
- `curl`, `wget` (setup scripts)
- `git` (development setup)
- Distribution package managers (`apt`, `dnf`, `nala`)

## Development Environment Setup

The setup scripts configure a complete development environment including:
- Zsh shell with Oh My Zsh framework
- Terminal utilities (fzf, zoxide, ranger)
- Text editors (vim, neovim with LazyVim)
- Development tools (git, tmux)
- Modern terminal emulator (ghostty) with Nerd Fonts

## Script Categories

### Calculators (`cal/`)
- Basic arithmetic operations with `bc` integration
- Scientific calculator with trigonometric functions
- Degree to radian conversion for trig operations

### Interactive Applications (`chatting-app.sh/`)  
- Single-user chat interface with message history
- Professional terminal theming using Catppuccin color palette
- Dynamic box drawing and text formatting

### System Management (`system.sh/`)
- Automated permission management for script execution
- Cross-distribution Linux setup automation
- Package installation with dependency checking
- Directory structure creation utilities

### Entertainment (`games.sh/`)
- Simple terminal-based games with input validation
- Random number generation and user interaction loops

This collection demonstrates practical bash scripting techniques including user interaction, system integration, mathematical computation, and terminal interface design.

