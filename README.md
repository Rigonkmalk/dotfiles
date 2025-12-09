# Rigonkmalk's Dotfiles

My dotfiles for personnal Linux use only

## Specification

[Hack Nerd fonts](https://www.nerdfonts.com/font-downloads)

## Installation

### Prerequisites

Before installing, ensure you have the following packages installed on your system:
- fzf
- ripgrep
- npm
- lazygit

### Quick Install

Clone this repository and run the install script:

```bash
git clone <your-repo-url> ~/devel/dotfiles
cd ~/devel/dotfiles
chmod +x install.sh
./install.sh --setup_dotfiles
```

### install.sh Usage

The `install.sh` script provides several functions to manage your dotfiles:

**Setup dotfiles** (copies nvim and tmux configs to ~/.config/):
```bash
./install.sh --setup_dotfiles
```

**Fetch from home directory** (sync changes from ~/.config/nvim back to this repo):
```bash
./install.sh --fetch_homedir
```

**Mirror to Windows** (for WSL users - copies nvim config to Windows AppData):
```bash
./install.sh --windows_mirror
```

**Show help**:
```bash
./install.sh --help
```

## Plugins

### Core/LSP
- **lsp** - Language Server Protocol configuration
- **cmp** - Autocompletion engine
- **lint** - Linting support
- **treesitter** - Syntax parsing and highlighting

### Debugging
- **dap** - Debug Adapter Protocol
- **debug** - Debugging utilities

### UI/Visual
- **colorscheme** - Color scheme configuration
- **lualine** - Status line
- **notify** - Notification manager
- **dressing** - UI improvements for vim.ui interfaces
- **nvim-colorizer** - Color code highlighting
- **indentblankline** - Indent guides
- **indent_line** - Alternative indent visualization
- **snacks** - Collection of small QoL features

### Navigation/Fuzzy Finding
- **telescope** - Fuzzy finder and picker
- **oil** - File explorer
- **flash** - Enhanced jump/search navigation

### Git Integration
- **gitsigns** - Git decorations and utilities
- **lazygit** - LazyGit integration

### Editing Enhancement
- **nvim-autopairs** - Automatic bracket/quote pairing
- **autopairs** - Alternative autopairs configuration
- **surround** - Surround text objects with quotes/brackets
- **treesj** - Split/join code blocks
- **repeat** - Repeat plugin actions with `.`
- **nvim-scissors** - Snippet management

### Utilities
- **tmux-navigator** - Seamless tmux/vim navigation
- **terminal** - Terminal integration
- **vim-maximizer** - Window maximizer
- **neoscroll** - Smooth scrolling
- **quickfix** - Quickfix list enhancements
- **whitespaces** - Whitespace management
- **weather** - Weather information display
- **encourage** - Motivational messages

### Markdown
- **markdown-preview** - Live markdown preview
- **markdown-toc** - Table of contents generator

### API Tools
- **swagger-preview** - Swagger/OpenAPI preview
