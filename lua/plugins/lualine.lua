-- Lualine Status Bar

return {
  enable = true,
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        theme = "onedark",
        globalstatus = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'toggleterm' } },
      },

      sections = {
        lualine_a = { { "mode", right_padding = 2 } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = '; ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            -- Display the LSP name
            show_name = true,
          },
          "encoding", "fileformat", "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      extensions = { "neo-tree", "lazy" },
    })
  end,
}
