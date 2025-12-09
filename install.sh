#!/usr/bin/env bash

dst="$HOME/.config/"

# Check if dependencies are installed
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install it."
    exit 1
fi

if ! command -v rg &> /dev/null; then
    echo "ripgrep is not installed. Please install it."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install it."
    exit 1
fi

if ! command -v lazygit &> /dev/null; then
    echo "lazygit is not installed. Please install it."
    exit 1
fi

# Function to display help information
show_help() {
    echo "Usage: $0 [function_name]"
    echo "Available functions:"
    echo "  --install_dependencies  - Install dependencies."
    echo "  --setup_dotfiles    - Set up dotfiles for nvim and tmux."
    echo "  --fetch_homedir     - Fetch nvim configuration from home directory."
    echo "  --windows_mirror    - Mirror nvim configuration to Windows directory."
    echo "  --help            - Display this help message."
}

# Function to set up dotfiles
setup_dotfiles() {
    cp -R nvim/ "$dst"
    cp -R tmux/ "$dst"
    echo "Dotfiles setup complete."
}

# Function to install dependencies by distributions (rhel + ubuntu)
install_dependencies() {
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y fzf ripgrep npm lazygit
    elif command -v dnf &> /dev/null; then
        sudo dnf update
        sudo dnf install -y fzf ripgrep npm lazygit
    else
        echo "Unsupported package manager."
        exit 1
    fi
}
# Function to fetch home directory configuration
fetch_homedir() {
    cp -R "$dst/nvim/" .
    echo "Home directory configuration fetched."
}

# Function to mirror configuration to Windows directory
windows_mirror() {
    cp -R "$dst/nvim/." /mnt/c/Users/PaulAzema/AppData/Local/nvim/
    echo "Configuration mirrored to Windows directory."
}

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "No function name provided."
    show_help
    exit 1
fi

# Handle function calls
case $1 in
    --install_dependencies)
        install_dependencies
        ;;
    --setup_dotfiles)
        install_dependencies
        setup_dotfiles
        ;;
    --fetch_homedir)
        fetch_homedir
        ;;
    --windows_mirror)
        windows_mirror
        ;;
    --help)
        show_help
        ;;
    *)
        echo "Invalid function name: $1"
        show_help
        exit 1
        ;;
esac
