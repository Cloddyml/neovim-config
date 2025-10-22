-- OneDark Colorscheme

return {
  "navarasu/onedark.nvim",
  priority = 1000,
  lazy = false,
  
  opts = {
    style = 'dark',
    transparent = false,
    term_colors = true,
    ending_tildes = false,
    
    code_style = {
      comments = 'italic',
      keywords = 'bold',
      functions = 'none',
      strings = 'none',
      variables = 'none',
    },
    
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  },
  
  config = function(_, opts)
    require('onedark').setup(opts)
    require('onedark').load()
  end,
}