-- Code Formatting

return {
  enable = true,
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },

  keys = {
    {
      "<leader>lf",
      function()
        local allowed_filetypes = { "lua", "python", "rust", "javascript", "javascriptreact", "html", "css", "json", "yaml", "toml" }
        local current_ft = vim.bo.filetype
        
        if vim.tbl_contains(allowed_filetypes, current_ft) then
          require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 1000 })
        else
          vim.notify("Formatting not configured for " .. current_ft, vim.log.levels.WARN)
        end
      end,
      mode = { "n", "v" },
      desc = "Format file",
    },
  },

  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        rust = { "rustfmt" },
        html = { "prettierd" },
        css = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        toml = { "taplo" }
      },

      -- Sync formatting
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },

      -- Async formatting
      format_after_save = {
        lsp_format = "fallback",
      },
    }
  end,
}