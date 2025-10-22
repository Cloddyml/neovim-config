-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
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

autocmd("FocusLost", {
  group = "AutoSave",
  desc = "Save on focus lost",
  pattern = "*",
  command = "silent! wa",
})

autocmd("BufLeave", {
  group = "AutoSave",
  desc = "Save on buffer leave",
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! update")
    end
  end,
})

-- Restore cursor position
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  desc = "Restore cursor to last position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Window management
augroup("WindowManagement", { clear = true })

autocmd("VimResized", {
  group = "WindowManagement",
  desc = "Equalize windows on resize",
  command = "tabdo wincmd =",
})

autocmd("FileType", {
  group = "WindowManagement",
  desc = "Close special windows with q",
  pattern = { "qf", "help", "man", "notify", "lspinfo", "startuptime", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- File type settings
augroup("FileTypeSettings", { clear = true })

autocmd("FileType", {
  group = "FileTypeSettings",
  desc = "Disable auto-commenting on newline",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

autocmd("FileType", {
  group = "FileTypeSettings",
  desc = "2-space indent for web languages",
  pattern = { "lua", "javascript", "typescript", "javascriptreact", "typescriptreact", 
              "json", "yaml", "html", "css", "scss" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

autocmd("FileType", {
  group = "FileTypeSettings",
  desc = "Enable wrap and spell for text files",
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
  desc = "Auto-close terminal",
  callback = function()
    vim.cmd("close")
  end,
})

-- Performance optimization for large files
augroup("Performance", { clear = true })

autocmd("BufReadPre", {
  group = "Performance",
  desc = "Disable features for large files",
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    if ok and stats and stats.size > 100000 then
      vim.opt_local.eventignore:append("all")
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.loadplugins = false
      vim.cmd("syntax clear")
      vim.notify("Large file detected, features disabled", vim.log.levels.WARN)
    end
  end,
})

-- UI enhancements
augroup("UIEnhancements", { clear = true })

autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = "UIEnhancements",
  desc = "Show cursorline in active window",
  callback = function()
    if vim.wo.cursorline ~= true then
      vim.wo.cursorline = true
    end
  end,
})

autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = "UIEnhancements",
  desc = "Hide cursorline in inactive window",
  callback = function()
    if vim.wo.cursorline ~= false then
      vim.wo.cursorline = false
    end
  end,
})

-- Git settings
augroup("GitSettings", { clear = true })

autocmd("FileType", {
  group = "GitSettings",
  desc = "Git commit message settings",
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
  end,
})

-- Cleanup
augroup("Cleanup", { clear = true })

autocmd("BufWritePre", {
  group = "Cleanup",
  desc = "Create directory before saving",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Macro recording notifications
augroup("Notifications", { clear = true })

autocmd("RecordingEnter", {
  group = "Notifications",
  desc = "Notify macro recording start",
  callback = function()
    vim.notify("Recording macro...", vim.log.levels.INFO, { title = "Macro", timeout = 500 })
  end,
})

autocmd("RecordingLeave", {
  group = "Notifications",
  desc = "Notify macro recording end",
  callback = function()
    vim.notify("Recording complete", vim.log.levels.INFO, { title = "Macro", timeout = 500 })
  end,
})