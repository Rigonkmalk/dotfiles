#!/usr/bin/env bash

# Enable strict error handling
set -euo pipefail

# Configuration
CONFIG_DIR="$HOME/.config/"
BACKUP_DIR="$HOME/dotfiles_backup"
LOG_FILE="$HOME/dotfiles_install.log"
WINDOWS_NVIM_DIR="/mnt/c/Users/PaulAzema/AppData/Local/nvim/"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Error handling function
error_exit() {
    log "${RED}ERROR:${NC} $1"
    exit 1
}

# Success message function
success_msg() {
    echo -e "${GREEN}✓${NC} $1"
    log "SUCCESS: $1"
}

# Warning message function
warning_msg() {
    echo -e "${YELLOW}⚠${NC} $1"
    log "WARNING: $1"
}

# Backup existing configuration
backup_config() {
    local source_dir="$1"
    local backup_name="$2"
    
    if [ -d "$source_dir" ]; then
        echo "Found existing configuration in $source_dir"
        read -p "Would you like to back it up to $BACKUP_DIR/$backup_name? [y/N] " -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$BACKUP_DIR"
            cp -R "$source_dir" "$BACKUP_DIR/$backup_name/"
            success_msg "Backed up existing configuration to $BACKUP_DIR/$backup_name/"
        else
            warning_msg "Skipping backup - existing configuration may be overwritten"
        fi
    fi
}

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
    echo "  --help              - Display this help message."
}

# Function to set up dotfiles
setup_dotfiles() {
    log "Starting dotfiles setup"
    
    # Check if source directories exist
    if [ ! -d "nvim" ]; then
        error_exit "nvim directory not found in current location"
    fi
    
    if [ ! -d "tmux" ]; then
        error_exit "tmux directory not found in current location"
    fi
    
    # Backup existing configurations
    backup_config "$CONFIG_DIR/nvim" "nvim_backup_$(date +%Y%m%d_%H%M%S)"
    backup_config "$CONFIG_DIR/tmux" "tmux_backup_$(date +%Y%m%d_%H%M%S)"
    
    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Copy configurations
    echo "Copying nvim configuration..."
    cp -R nvim/ "$CONFIG_DIR/" || error_exit "Failed to copy nvim configuration"
    
    echo "Copying tmux configuration..."
    cp -R tmux/ "$CONFIG_DIR/" || error_exit "Failed to copy tmux configuration"
    
    success_msg "Dotfiles setup complete."
    log "Dotfiles setup completed successfully"
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
    log "Starting fetch from home directory"
    
    # Check if source directory exists
    if [ ! -d "$CONFIG_DIR/nvim" ]; then
        error_exit "nvim configuration not found in $CONFIG_DIR"
    fi
    
    # Backup existing local configuration
    backup_config "nvim" "local_nvim_backup_$(date +%Y%m%d_%H%M%S)"
    
    # Copy configuration
    echo "Fetching nvim configuration from home directory..."
    cp -R "$CONFIG_DIR/nvim/" . || error_exit "Failed to fetch nvim configuration"
    
    success_msg "Home directory configuration fetched."
    log "Fetch from home directory completed successfully"
}

# Function to mirror configuration to Windows directory
windows_mirror() {
    log "Starting Windows mirror operation"
    
    # Check if Windows directory exists
    if [ ! -d "$WINDOWS_NVIM_DIR" ]; then
        warning_msg "Windows nvim directory not found, attempting to create it"
        mkdir -p "$WINDOWS_NVIM_DIR" || error_exit "Failed to create Windows nvim directory"
    fi
    
    # Check if source directory exists
    if [ ! -d "$CONFIG_DIR/nvim" ]; then
        error_exit "nvim configuration not found in $CONFIG_DIR"
    fi
    
    # Backup existing Windows configuration
    backup_config "$WINDOWS_NVIM_DIR" "windows_nvim_backup_$(date +%Y%m%d_%H%M%S)"
    
    # Copy configuration
    echo "Mirroring configuration to Windows directory..."
    cp -R "$CONFIG_DIR/nvim/." "$WINDOWS_NVIM_DIR/" || error_exit "Failed to mirror configuration to Windows"
    
    success_msg "Configuration mirrored to Windows directory."
    log "Windows mirror operation completed successfully"
}

# Initialize log file
mkdir -p "$(dirname "$LOG_FILE")"
echo "Dotfiles Install Log - $(date)" > "$LOG_FILE"

# Check if an argument is provided
if [ -z "${1:-}" ]; then
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
