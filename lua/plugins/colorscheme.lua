-- OneDark Colorscheme Configuration
return {
  enabled = true,
  "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  lazy = false,
  config = function()
    require('onedark').setup {
      style = 'deep',               -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false,          -- Enable this to disable setting the background color
      term_colors = true,           -- Change terminal color as per the selected theme style
      ending_tildes = false,        -- Show the end-of-buffer tildes
      cmp_itemkind_reverse = false, -- Reverse item kind highlights in cmp menu

      code_style = { -- Specify code styles
        comments = 'italic', -- 'none', 'italic', 'bold', 'underline', etc.
        keywords = 'bold',
        functions = 'none',
        strings = 'none',
        variables = 'none',
        constants = 'italic,bold',
      },

      lualine = {
        transparent = false, -- Enable this to make lualine transparent
      },

      -- Custom Highlights --
      colors = {},     -- Override default colors
      highlights = {}, -- Override highlight groups

      diagnostics = {
        darker = true,     -- darker colors for diagnostic
        undercurl = true,  -- use undercurl for diagnostics
        background = true, -- use background color for virtual text
      },
    }
    require('onedark').load()
  end
}