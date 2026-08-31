# Rigonkmalk's Dotfiles

Personal configuration files for macOS (primary) and Linux.

## Contents

| Directory | Target | Description |
| --- | --- | --- |
| `nvim/` | `~/.config/nvim/` | Neovim configuration built on `vim.pack` and `mini.nvim` |
| `fish/` | `~/.config/fish/` | Fish shell config, functions, completions and `conf.d` snippets |
| `alacritty/` | `~/.config/alacritty/` | Alacritty terminal (TOML format, requires Alacritty >= 0.14) |
| `lazygit/` | `~/.config/lazygit/` | LazyGit theme and UI settings |
| `mpv/` | `~/.config/mpv/` | mpv player options (yt-dlp integration) |
| `install.sh` | — | Installation and synchronization script |

## Requirements

### Runtime dependencies

Checked by `install.sh` before any operation:

- `fzf`
- `ripgrep`
- `npm`
- `lazygit`
- `mpv`
- `alacritty`
- `fish`

### Used by the fish functions

`bat` (`cat`), `eza` (`ls`), `duf` (`df`), `jq` and the AWS CLI (EC2 helpers).

### Fonts

- [FantasqueSansM Nerd Font Mono](https://www.nerdfonts.com/font-downloads) — Alacritty
- [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) — Neovim GUI fallback

## Installation

```bash
git clone <your-repo-url> ~/devel/dotfiles
cd ~/devel/dotfiles
./install.sh --setup_dotfiles
```

Existing configurations are detected and can be backed up interactively to
`~/dotfiles_backup/`. Every run is logged to `~/dotfiles_install.log`.

### `install.sh` usage

```bash
./install.sh --install_dependencies  # Install dependencies (apt or dnf)
./install.sh --setup_dotfiles        # Copy the repo configs to ~/.config/
./install.sh --fetch_homedir         # Copy the ~/.config/ configs back to the repo
./install.sh --windows_mirror        # Mirror the nvim config to Windows AppData (WSL)
./install.sh --help                  # Show help
```

> `--install_dependencies` only supports `apt` and `dnf`; on macOS install the
> packages with Homebrew.

## Neovim

Plugins are managed with the built-in `vim.pack` — no external plugin manager.
Versions are pinned in `nvim/nvim-pack-lock.json`.

### Layout

- `init.lua` — plugin declarations and setup
- `lua/config/vim.lua` — core options, leader key (`<Space>`), diagnostics keymaps
- `lua/lsp.lua` — LSP servers, diagnostics display, format on save
- `lua/keymap.lua` — keymaps
- `lua/utils.lua` — helpers (OS detection)

### Plugins

- [mini.nvim](https://github.com/nvim-mini/mini.nvim) — `basics`, `files`, `icons`, `pairs`,
  `keymap`, `completion`, `notify`, `pick`, `comment`, `cursorword`, `diff`, `tabline`,
  `statusline`, `indentscope`, `extra`, `git`, `sessions`, `bufremove`, `move`
- [mason.nvim](https://github.com/mason-org/mason.nvim) — LSP/tooling installer
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) — colorscheme (`dragon`, transparent)
- [neoterm.nvim](https://github.com/itmecho/neoterm.nvim) — floating terminal

### LSP servers

`lua-language-server`, `vtsls`, `biome`, `rust-analyzer`, `css-variables-language-server`,
`vscode-css-language-server`, `marksman`, `gdscript` (TCP, port `GDScript_Port` or `6005`)
and `tailwindcss`.

Format on save is enabled; the preferred formatter per filetype is `biome` for
JS/TS/JSON, `cssls` for CSS/SCSS/LESS and `luals` for Lua.

### Keymaps

Leader is `<Space>`.

| Key | Action |
| --- | --- |
| `<leader>e` | Open the file explorer (`mini.files`) at the current file |
| `<leader>q` | Wipe out the current buffer |
| `<leader>p` | Copy the relative path of the current file to the clipboard |
| `<leader>sf` | Pick files |
| `<leader>sb` | Pick buffers |
| `<leader>sg` | Live grep |
| `<leader>t` | Toggle the terminal |
| `<esc>` (terminal) | Close the terminal |
| `[d` / `]d` | Previous / next diagnostic |
| `<Tab>` / `<S-Tab>` | Navigate the completion popup |
| `<M-arrows>` | Move the line or the selection |

## Fish

- `config.fish` — interactive environment (AWS profile, `EDITOR`, `PATH`, pnpm, OrbStack)
- `fish_plugins` — [fisher](https://github.com/jorgebucaran/fisher) plugins: `fisher`, `fish-ssh-agent`
- `conf.d/` — ssh-agent bootstrap, rustup, Teleport paths and `cdt` / `cdtl` aliases
- `functions/` — command overrides and AWS helpers

### Command overrides

| Command | Replaced by |
| --- | --- |
| `cat` | `bat -p` |
| `ls` | `eza -al --icons --group-directories-first` |
| `df` | `duf` |

### AWS helpers

| Function | Description |
| --- | --- |
| `sso` | `aws configure sso` |
| `myInstances` | List the instances tagged `CustomerCare-pazema` |
| `ccInstances` | List the instances tagged `CustomerCare` |
| `myOnDemandInstances` | List the on-demand instances tagged `Rigonkmalk*` |
| `startInstances` | Start the instances from `myInstances` (or those passed as arguments) |
| `startMyOnDemandInstances` | Start the on-demand instances |
| `stopMyOnDemandInstances` | Stop the on-demand instances |
| `aws-start` / `aws-stop` | Start / stop the given instance IDs |

### Other functions

- `centreon-update` — run `~/devel/worker/git_pull.sh`
- `docker-cc` — SSH to the Customer Care Docker host
