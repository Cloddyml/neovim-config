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

-- Load configuration module
require("config")

-- Load custom user config if exists
local has_custom, custom = pcall(require, "custom.user")
if has_custom then
  custom.setup()
end

