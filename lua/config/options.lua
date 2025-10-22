-- Editor Settings

local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- Line wrapping
opt.wrap = false
opt.linebreak = true

-- Files and backups
opt.undofile = true
opt.swapfile = false

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false
opt.showcmd = true

-- Mouse and clipboard
opt.mouse = "a"
opt.mousefocus = true
opt.clipboard = "unnamedplus"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.updatetime = 100
opt.timeoutlen = 300

-- Misc
opt.virtualedit = "block"
opt.completeopt = "menu,menuone,noselect"
opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ",
  diff = "⣿",
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}
opt.shortmess:append("c")

-- Shell
local function get_shell()
  if vim.fn.has("win32") == 1 then
    return "cmd.exe"
  elseif vim.fn.executable("zsh") == 1 then
    return "/bin/zsh"
  else
    return "/bin/bash" -- bash fallback
  end
end

-- Legacy settings
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"