-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-save
augroup("AutoSave", { clear = true })
autocmd({ "FocusLost" }, {
  group = "AutoSave",
  desc = "Auto-save when focus is lost",
  pattern = "*",
  command = "silent! wa",
})

autocmd({ "BufLeave" }, {
  group = "AutoSave",
  desc = "Auto-save when buffer is left",
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! update")
    end
  end,
})

-- Trim trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  desc = "Trim trailing whitespace on save",
  pattern = "*",
  callback = function()
    -- Save view position
    local view = vim.fn.winsaveview()
    -- Trim trailing whitespace
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    -- Restore view position
    vim.fn.winrestview(view)
  end,
})

-- Restore cursor position when reopening files
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  desc = "Restore cursor position when reopening files",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Enable cursorline in active window only
augroup("CursorLine", { clear = true })
autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = "CursorLine",
  desc = "Enable cursorline in active window",
  callback = function()
    if vim.wo.cursorline ~= true then
      vim.wo.cursorline = true
    end
  end,
})

autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = "CursorLine",
  desc = "Disable cursorline in inactive window",
  callback = function()
    if vim.wo.cursorline ~= false then
      vim.wo.cursorline = false
    end
  end,
})

-- Window management
augroup("WindowManagement", { clear = true })
autocmd("VimResized", {
  group = "WindowManagement",
  desc = "Equalize window sizes on Vim resize",
  command = "tabdo wincmd =",
})

autocmd("FileType", {
  group = "WindowManagement",
  desc = "Close certain filetypes with 'q'",
  pattern = { "help", "qf", "lspinfo", "man", "startuptime", "checkhealth", "notify" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
})

autocmd("FileType", {
  group = "WindowManagement",
  desc = "Disable line numbers for certain filetypes",
  pattern = { "alpha", "dashboard", "NvimTree", "Trouble", "lir", "Outline", "spectre_panel" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Filetype specific settings
augroup("FiletypeSettings", { clear = true })
autocmd("FileType", {
  group = "FiletypeSettings",
  desc = "2-space indent for web languages",
  pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte",
    "json", "yaml", "lua", "xml", "scss" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

autocmd("FileType", {
    group = "FiletypeSettings",
    desc = "Enable wrap and spellcheck for text files",
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = "TerminalSettings",
  desc = "Enter insert mode in terminal",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

autocmd("TermClose", {
  group = "TerminalSettings",
  desc = "Close terminal buffer on exit",
  callback = function(event)
    vim.cmd("close")
  end,
})

-- Git settings
augroup("GitSettings", { clear = true })
autocmd("FileType", {
  group = "GitSettings",
  desc = "Disable line numbers in gitcommit",
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
  end,
})

-- Auto-create directories when saving files
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoCreateDir",
  desc = "Auto-create parent directories when saving files",
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})