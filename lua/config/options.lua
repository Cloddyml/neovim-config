-- Global options --

-- LazyVim auto format
vim.g.autoformat = true

-- Snacks animations
vim.g.snacks_animate = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "auto"

-- LazyVim completion engine to use.
-- Can be one of: nvim-cmp, blink.cmp
-- Leave it to "auto" to automatically use the completion engine
-- enabled with `:LazyExtras`
vim.g.lazyvim_cmp = "auto"

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = true

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
vim.g.trouble_lualine = true


-- Editor Settings --

local opt = vim.opt

-- Indentation
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftwidth = 4     -- Size of an indent
opt.tabstop = 4        -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

-- Line wrapping
opt.wrap = false     -- Disable line wrapping
opt.linebreak = true -- Wrap lines at convenient points

-- Files and backups
opt.undofile = true  -- Enable persistent undo
opt.swapfile = false -- Disable swap files

-- Search
opt.ignorecase = true -- Case ignore search patterns
opt.smartcase = true  -- Case sensitive if expression contains capital letters
opt.hlsearch = true   -- Highlight search matches
opt.incsearch = true  -- Show search matches as you type

-- UI
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.termguicolors = true  -- Enable true color support
opt.cursorline = true     -- Highlight the current line
opt.signcolumn = "yes"    -- Always show the sign column
-- opt.list = true           -- Show whitespace characters
opt.scrolloff = 8         -- Minimum number of screen lines to keep above and below the cursor
opt.smoothscroll = true   -- Enable smooth scrolling
opt.sidescrolloff = 8     -- Minimum number of screen columns to keep to the left and right of the cursor
opt.showmode = false      -- Don't show mode since we have a statusline
opt.showcmd = true        -- Show command in the last line of the screen

-- Mouse, clipboard, arrows and cursor
opt.mouse = "a"               -- Enable mouse support
opt.mousefocus = true         -- Focus window under mouse
-- opt.guicursor = ""            -- Set cursor styles
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically.
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Sync with system clipboard
-- opt.arrowkeys = false         -- Disable arrow keys

-- Splits
opt.splitright = true -- Vertical splits will be to the right
opt.splitbelow = true -- Horizontal splits will be below

-- Performance
opt.updatetime = 100 -- Faster completion (4000ms default)
opt.timeoutlen = 300 -- By default timeoutlen is 1000 ms

-- Misc
opt.spelllang = { "en", "ru" }              -- Set spellcheck language to English and Russian
opt.virtualedit = "block"                   -- Allow cursor to move where there is no text in visual block mode
opt.completeopt = "menu,menuone,noselect"   -- Completion options
opt.fillchars = {                           -- Customize fill characters
  vert = "│",     -- Vertical separator
  fold = "⠀",     -- Folded line
  eob = " ",      -- End of buffer
  diff = "⣿",     -- Diff filler
  msgsep = "‾",   -- Message separator
  foldopen = "▾", -- Open fold symbol
  foldsep = "│",  -- Fold separator
  foldclose = "▸" -- Closed fold symbol
}
opt.shortmess:append("c")                   -- Don't show completion messages
opt.formatoptions:remove({ "c", "r", "o" }) -- Don't auto-wrap comments