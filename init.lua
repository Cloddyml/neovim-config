-- Neovim Configuration
-- Minimum required version: 0.11.2

local required_version = "0.11.2"
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
    { cmd = { "gcc", "clang", "cl" }, name = "C/C++ compiler", critical = true },
    { cmd = { "curl", "wget" }, name = "Download tool (curl or wget)", critical = false },
  }

  local missing_critical = {}
  local missing_optional = {}

  for _, dep in ipairs(deps) do
    local found = false
    local cmds = type(dep.cmd) == "table" and dep.cmd or { dep.cmd }
    
    for _, cmd in ipairs(cmds) do
      if vim.fn.executable(cmd) == 1 then
        found = true
        break
      end
    end
    
    if not found then
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

-- Auto-download spell dictionaries (cross-platform)
local function ensure_spell_files()
  local spell_dir = vim.fn.stdpath("data") .. "/site/spell"
  vim.fn.mkdir(spell_dir, "p")
  
  for _, lang in ipairs({ "en", "ru" }) do
    local spell_file = spell_dir .. "/" .. lang .. ".utf-8.spl"
    if vim.fn.filereadable(spell_file) == 0 then
      local url = string.format(
        "https://ftp.nluug.nl/pub/vim/runtime/spell/%s.utf-8.spl",
        lang
      )
      vim.notify("Downloading spell dictionary: " .. lang, vim.log.levels.INFO)
      
      -- Detect platform and use appropriate download command
      local cmd
      if vim.fn.has("win32") == 1 then
        cmd = { "powershell", "-Command", 
          string.format('Invoke-WebRequest -Uri "%s" -OutFile "%s"', url, spell_file) }
      elseif vim.fn.executable("curl") == 1 then
        cmd = { "curl", "-fLo", spell_file, "--create-dirs", url }
      elseif vim.fn.executable("wget") == 1 then
        cmd = { "wget", "-O", spell_file, url }
      else
        vim.notify("No download tool found (curl/wget)", vim.log.levels.ERROR)
        return
      end
      
      vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
          if code == 0 then
            vim.notify("Spell dictionary downloaded: " .. lang, vim.log.levels.INFO)
          else
            vim.notify("Failed to download: " .. lang, vim.log.levels.WARN)
          end
        end
      })
    end
  end
end

-- Defer spell check to avoid blocking startup
vim.defer_fn(ensure_spell_files, 100)

-- Enable faster loading via bytecode cache
vim.loader.enable()

-- Load configuration module
require("config")

-- Load custom user config if exists
local has_custom, custom = pcall(require, "custom.user")
if has_custom then
  custom.setup()
end

