-- Global Keymaps
-- Plugin-specific keymaps are set in their respective config files

local keymap = vim.keymap

-- Window navigation (Ctrl+hjkl)
keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move to left window' })
keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move to bottom window' })
keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move to top window' })
keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move to right window' })

-- Splits
keymap.set('n', '|', ':vsplit<CR>', { desc = 'Vertical split' })
keymap.set('n', '\\', ':split<CR>', { desc = 'Horizontal split' })

-- Save and quit
keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })
keymap.set('n', '<leader>Q', ':qa<CR>', { desc = 'Quit Neovim' })

-- Exit insert mode
keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('i', 'kk', '<Esc>', { desc = 'Exit insert mode' })

-- Clipboard
keymap.set('n', '<leader>y', ':%y+<CR>', { desc = 'Copy all to clipboard' })
keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without saving' })
keymap.set('v', '<leader>d', '"_d', { desc = 'Delete without saving' })

-- Search
keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Move lines in visual mode
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })

-- Stay in indent mode
keymap.set('v', '<', '<gv', { desc = 'Indent left' })
keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Center screen on scroll
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down centered' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up centered' })

-- Center on search
keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Utilities
keymap.set('n', '<leader>tw', ':set wrap!<CR>', { desc = 'Toggle wrap' })
keymap.set('n', '<leader>fp', ':echo expand("%:p")<CR>', { desc = 'Show file path' })
keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = 'Reload config' })

-- Quickfix
keymap.set('n', '<leader>xq', ':copen<CR>', { desc = 'Open quickfix' })
keymap.set('n', '<leader>xc', ':cclose<CR>', { desc = 'Close quickfix' })
keymap.set('n', '[q', ':cprev<CR>', { desc = 'Previous quickfix' })
keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next quickfix' })

-- Make file executable
keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { desc = 'Make executable', silent = true })