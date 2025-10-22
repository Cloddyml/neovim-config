-- Neovim Configuration
-- Minimum required version: 0.10.0

local required_version = "0.10.0"
if vim.fn.has("nvim-" .. required_version) == 0 then
  vim.api.nvim_err_writeln(
    "Neovim " .. required_version .. "+ required. Current: " .. tostring(vim.version())
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Check critical dependencies
local function check_dependencies()
  local deps = {
    { cmd = "git", name = "Git", critical = true },
    { cmd = "rg", name = "ripgrep", critical = false },
    { cmd = "fd", name = "fd", critical = false },
  }

  local missing_critical = {}
  local missing_optional = {}

  for _, dep in ipairs(deps) do
    if vim.fn.executable(dep.cmd) == 0 then
      if dep.critical then
        table.insert(missing_critical, dep.name)
      else
        table.insert(missing_optional, dep.name)
      end
    end
  end

  if #missing_critical > 0 then
    vim.api.nvim_err_writeln(
      "Missing critical dependencies:\n" .. table.concat(missing_critical, "\n")
    )
    vim.fn.getchar()
    vim.cmd.quit()
  end

  if #missing_optional > 0 then
    vim.defer_fn(function()
      vim.notify(
        "Optional dependencies missing:\n" .. table.concat(missing_optional, "\n"),
        vim.log.levels.WARN
      )
    end, 1000)
  end
end

check_dependencies()

-- Enable faster loading via bytecode cache
vim.loader.enable()

-- Load configuration modules
require("config.lazy")      -- Plugin manager
require("config.options")   -- Editor settings
require("config.keymaps")   -- Global keybindings
require("config.colors")    -- Theme and colors
require("config.autocmds")  -- Autocommands

-- Load custom user config if exists
local has_custom, custom = pcall(require, "custom.user")
if has_custom then
  custom.setup()
end

-- Utility commands
vim.api.nvim_create_user_command("CheckConfig", function()
  local stats = require("lazy").stats()
  local clients = vim.lsp.get_active_clients()
  
  local lines = {
    "Neovim Configuration Status:",
    "",
    "Version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
    "Leader: " .. vim.g.mapleader,
    string.format("Plugins: %d installed, %d loaded", stats.count, stats.loaded),
    "",
  }
  
  if #clients > 0 then
    table.insert(lines, "Active LSP Servers:")
    for _, client in ipairs(clients) do
      table.insert(lines, "  • " .. client.name)
    end
  end
  
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^config") or name:match("^plugins") or name:match("^custom") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Configuration reloaded", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("EditConfig", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, {})