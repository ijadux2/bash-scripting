# Bash Script Collection

A comprehensive collection of interactive bash scripts organized into functional categories, serving as a personal utility toolkit with applications, games, system configuration tools, and calculators.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Script Categories](#script-categories)
- [Usage Examples](#usage-examples)
- [System Setup](#system-setup)
- [Contributing](#contributing)
- [Author](#author)

## 🔍 Overview

This repository contains a modular collection of bash utilities designed for:
- **Productivity**: Calculators and system tools
- **Entertainment**: Simple terminal games
- **Communication**: Single-user chat interface with beautiful theming
- **System Management**: Development environment setup and package management

All scripts are implemented in pure bash with interactive interfaces and visual feedback.

## 📦 Prerequisites

### Required Dependencies
- **bash** (4.0+ recommended)
- **bc** (for calculator functions)
- **curl** and **wget** (for setup scripts)
- **git** (for development setup)

### Optional Dependencies
- **tput** (for enhanced terminal formatting)
- Package managers: `apt`, `dnf`, or `nala` (for system setup scripts)

### Supported Operating Systems
- Ubuntu/Debian (primary support)
- Fedora (supported)
- Other Linux distributions (basic compatibility)

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/ijadux2/bash-scripting.git
cd bash.sh
```

### 2. Make Scripts Executable
```bash
# Make all scripts executable at once
./execute.sh

# Or make specific directory scripts executable
cd system.sh && ./execute.sh
```

### 3. Run Your First Application
```bash
# Try the basic calculator
cd cal && ./calculator.sh

# Or start the themed chat application
cd chatting-app.sh && ./chat.sh
```

## 📁 Script Categories

### 🧮 Calculators (`cal/`)
- **`calculator.sh`** - Basic arithmetic operations (+, -, ×, ÷)
- **`cal2.sh`** - Scientific calculator with trigonometric functions

```bash
cd cal
./calculator.sh    # Basic calculator
./cal2.sh         # Scientific calculator
```

### 💬 Chat Application (`chatting-app.sh/`)
- **`chat.sh`** - Single-user chat interface with Catppuccin Mocha theming
- **`receiver-chat.sh`** - Additional chat functionality (in development)

```bash
cd chatting-app.sh
./chat.sh         # Start themed chat interface
```

### 🎮 Games (`games.sh/`)
- **`game.sh`** - Number guessing game with input validation

```bash
cd games.sh
./game.sh         # Start number guessing game
```

### 🛠️ System Utilities (`system.sh/`)
- **`face.sh`** - Animated ASCII face with blinking animation
- **`stucture.sh`** - Directory structure creation utility
- **`execute.sh`** - Make local scripts executable

```bash
cd system.sh
./face.sh         # Animated ASCII face
./stucture.sh     # Create directory structures
```

#### Setup Scripts (`system.sh/setup.sh/`)
- **`setup.sh`** - Ubuntu/Debian development environment setup
- **`fedora-setup.sh`** - Fedora development environment setup
- **`update.sh`** - System update utilities

```bash
cd system.sh/setup.sh
./setup.sh        # Ubuntu/Debian setup
./fedora-setup.sh # Fedora setup
```

#### Package Management (`system.sh/system-pkgs/`)
- **`pkgs.sh`** - Automated package installation with dependency checking

```bash
cd system.sh/system-pkgs
./pkgs.sh         # Install common packages
```

## 💡 Usage Examples

### Basic Calculator Usage
```bash
cd cal && ./calculator.sh
# Enter first number: 15
# Enter second number: 3
# Choose operation:
# 1) Addition (+)
# 2) Subtraction (-)
# 3) Multiplication (*)
# 4) Division (/)
# Result: 18
```

### Scientific Calculator with Trigonometry
```bash
cd cal && ./cal2.sh
# Choose operation:
# 5) Sine (sin) - Enter angle in degrees
# Enter angle in degrees: 30
# Result: 0.5000
```

### Chat Application Features
- **Catppuccin Mocha color scheme** with ANSI escape codes
- **Message history** with timestamps
- **Professional terminal theming** with box drawing
- **Interactive interface** with proper cursor management

### System Setup Features
The setup scripts install and configure:
- **Zsh shell** with Oh My Zsh framework
- **Development tools**: vim, neovim with LazyVim, tmux
- **Terminal utilities**: fzf, zoxide, ranger
- **Modern terminal**: ghostty with Nerd Fonts
- **Package managers**: pacstall (for Ubuntu/Debian)

## 🔧 System Setup

### Ubuntu/Debian Development Environment
```bash
cd system.sh/setup.sh && ./setup.sh
```

This script installs:
- Git, curl, wget
- Vim and Neovim with LazyVim configuration
- Zsh with Oh My Zsh and custom prompt
- Terminal utilities (fzf, zoxide)
- Ghostty terminal with JetBrains Mono Nerd Font
- Pacstall package manager
- Development applications

### Fedora Development Environment
```bash
cd system.sh/setup.sh && ./fedora-setup.sh
```

### Package Installation
```bash
cd system.sh/system-pkgs && ./pkgs.sh
```

Automatically installs and checks for:
- vim, tmux, vlc, ranger

## 🎨 Design Features

### Terminal Theming
- **Catppuccin Mocha** color palette implementation
- **ANSI escape codes** for true color support
- **Dynamic box drawing** with Unicode characters
- **Cursor management** for smooth interfaces

### User Experience
- **Input validation** with error handling
- **Loading spinners** with visual feedback
- **Interactive prompts** with clear instructions
- **Graceful exits** with proper cleanup

### Code Organization
- **Modular structure** with functional separation
- **Consistent naming** conventions
- **Documented functions** with clear purposes
- **Cross-distribution** compatibility

## 🤝 Contributing

Feel free to:
1. Fork the repository
2. Create feature branches
3. Add new utilities or improve existing ones
4. Submit pull requests

### Adding New Scripts
1. Place scripts in appropriate category directories
2. Make them executable: `chmod +x script.sh`
3. Follow existing patterns for user interaction
4. Include proper error handling and validation

## 👨‍💻 Author

**Kumar Vaibhav (ijadux2)**
- Personal utility toolkit for Linux development
- Focus on interactive terminal applications
- Emphasis on visual design and user experience

---
## Tree
 .
├──  cal
│  ├──  cal2.sh
│  └──  calculator.sh
├──  chatting-app.sh
│  ├──  chat.sh
│  └──  receiver-chat.sh
├──  execute.sh
├──  games.sh
│  └──  game.sh
├──  README.md
├──  system.sh
│  ├──  execute.sh
│  ├──  face.sh
│  ├──  setup.sh
│  │  ├──  additional-pkgs.sh
│  │  ├──  jadux2_.sh
│  │  ├──  pkgs.sh
│  │  ├──  setup.sh
│  │  └──  update.sh
│  ├──  stucture.sh
│  └──  system-pkgs
│     ├──  pkgs.nix
│     └──  pkgs.sh
└──  WARP.md
---

## 📝 Notes

- All scripts are designed for **personal use** and educational purposes
- Chat application messages are **not encrypted** - use appropriately
- Setup scripts require **sudo privileges** for system modifications
- Scripts are tested primarily on **Ubuntu/Debian** and **Fedora**

## 🔗 Related Projects

- [LazyVim](https://github.com/LazyVim/starter) - Neovim configuration
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) - Zsh framework
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Color scheme

---

**Enjoy exploring and customizing your terminal experience!** 🚀
