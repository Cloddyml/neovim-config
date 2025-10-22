-- Theme and Color Configuration

vim.opt.termguicolors = true

-- Safe colorscheme loader
local function set_colorscheme(name)
  local ok, _ = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.WARN)
    return false
  end
  return true
end

-- Apply colorscheme (loaded from lua/plugins/colorscheme.lua)
set_colorscheme("onedark")

-- Custom color overrides
local function apply_custom_colors()
  vim.api.nvim_set_hl(0, "Normal", { bg = "#120E27" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0E0A23" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

apply_custom_colors()

-- Reapply custom colors when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("CustomColors", { clear = true }),
  callback = apply_custom_colors,
  desc = "Apply custom colors after colorscheme change",
})

-- Utility function for changing colorscheme
_G.change_colorscheme = function(scheme)
  if set_colorscheme(scheme) then
    vim.notify("Colorscheme changed: " .. scheme, vim.log.levels.INFO)
  end
end