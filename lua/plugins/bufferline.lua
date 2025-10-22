-- Bufferline Tab Bar

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<leader>xx", "<cmd>BufferLinePickClose<cr>", desc = "Close buffer" },
    { "<leader>xr", "<cmd>BufferLineCloseRight<cr>", desc = "Close right" },
    { "<leader>xl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close left" },
    { "<leader>xo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
  },
  
  opts = {
    options = {
      mode = "buffers",
      themable = true,
      separator_style = "thin",
      indicator = { icon = '▎', style = 'icon' },
      
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      
      offsets = {
        { filetype = "neo-tree", text = "File Explorer", text_align = "center", separator = true }
      },
      
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      color_icons = true,
    },
  },
}