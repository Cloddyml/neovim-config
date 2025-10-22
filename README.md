# Neovim Configuration

Personal Neovim configuration optimized for development with Neovim 0.10+.

## Features

- ⚡ Fast startup with lazy loading
- 🎨 OneDark theme with custom colors
- 🔍 Telescope fuzzy finder
- 📁 Neo-tree file explorer
- 🔧 LSP support via Mason
- 💬 Smart autocompletion with nvim-cmp
- 🌳 Treesitter syntax highlighting
- 🔱 Git integration with Gitsigns
- ✨ Code formatting with Conform
- 💻 Integrated terminal with ToggleTerm
- 📊 Beautiful statusline and bufferline

## Requirements

- Neovim 0.10.0+
- Git (required)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (optional, for Telescope)
- [fd](https://github.com/sharkdp/fd) (optional, for Telescope)
- Node.js (optional, for LSP servers)

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone https://github.com/couguar/nvim-config.git ~/.config/nvim

# Start Neovim (plugins will install automatically)
nvim
```

## Key Bindings

### General
- `<Space>` - Leader key
- `jj` or `kk` - Exit insert mode
- `<C-h/j/k/l>` - Navigate windows
- `|` / `\` - Split window vertically/horizontally

### Files & Navigation
- `<leader>e` - File explorer (float)
- `<leader>ff` - Find files
- `<leader>fr` - Recent files
- `<leader>fw` - Find text (grep)
- `<leader>fb` - Open buffers

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>la` - Code actions
- `<leader>lr` - Rename symbol
- `<leader>lf` - Format file

### Git
- `<leader>gg` - LazyGit
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk
- `]c` / `[c` - Next/previous hunk

### Terminal
- `<C-\>` - Toggle terminal
- `<leader>tf` - Float terminal

## Plugin Management

- `:Lazy` - Open plugin manager
- `:Mason` - Install LSP servers, formatters, etc.
- `:CheckConfig` - Verify configuration status

## Customization

Personal settings can be added to `lua/custom/user.lua` (not tracked by git).

## Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/              # Core configuration
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── options.lua      # Editor settings
│   │   ├── keymaps.lua      # Global keybindings
│   │   ├── colors.lua       # Theme configuration
│   │   └── autocmds.lua     # Autocommands
│   ├── plugins/             # Plugin configurations
│   │   ├── lsp.lua
│   │   ├── cmp.lua
│   │   ├── telescope.lua
│   │   └── ...
│   └── custom/              # Personal settings (gitignored)
│       └── user.lua
└── lazy-lock.json           # Plugin version lockfile
```

## License

MIT