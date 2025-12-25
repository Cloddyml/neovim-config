-- Bufferline Tab Bar

return {
  enable = true,
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },

  config = function()
    require("bufferline").setup {

      options = {
        mode = "buffers",
        separator_style = "slant",
        themable = true,

        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
      end,
      offsets = {
        { filetype = "neo-tree", text = "File Explorer", text_align = "center", separator = true }
      },

      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      color_icons = true,
      }
    }

    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer", silent = true })
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer", silent = true })

    vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer", silent = true })
    vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick Close", silent = true })
    vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Left", silent = true })
    vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Right", silent = true })
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close Others", silent = true })
  end
}
