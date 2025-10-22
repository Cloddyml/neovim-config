-- Code Formatting

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end,
      mode = { "n", "v" },
      desc = "Format file",
    },
  },
  
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      go = { "gofmt", "goimports" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
    },
    
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
  },
}