-- Treesitter Syntax Highlighting

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "query",
      "bash", "python", "javascript", "typescript",
      "html", "css", "json", "yaml", "markdown",
      "c", "cpp", "rust", "go",
    },
    
    auto_install = true,
    
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    
    indent = { enable = true },
    
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
  
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}