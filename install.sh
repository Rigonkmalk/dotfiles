#!/usr/bin/env bash

dst="$HOME/.config/"

# Function to display help information
show_help() {
    echo "Usage: $0 [function_name]"
    echo "Available functions:"
    echo "  --setup_dotfiles    - Set up dotfiles for nvim and tmux."
    echo "  --fetch_homedir     - Fetch nvim configuration from home directory."
    echo "  --windows_mirror    - Mirror nvim configuration to Windows directory."
    echo "  --help            - Display this help message."
}

# Function to set up dotfiles
setup_dotfiles() {
    cp -r nvim/ "$dst"
    cp -r tmux/ "$dst"
    echo "Dotfiles setup complete."
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
    --setup_dotfiles)
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
