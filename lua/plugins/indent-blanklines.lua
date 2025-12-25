-- Indent Blankline Configuration

return {
  enable = true,
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    require("ibl").setup {
      indent = { char = "│", tab_char = "│" },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "dashboard",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "alpha",
          "checkhealth",
          "lspinfo",
          "man",
          "TelescopePrompt",
          "TelescopeResults",
        },
        buftypes = { "terminal", "nofile", "prompt", "quickfix" },
      },

    }
  end,

}