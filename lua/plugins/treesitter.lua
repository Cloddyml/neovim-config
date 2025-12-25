-- Treesitter Syntax Highlighting

return {
  enabled = true,
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",

  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master", lazy = false },
  },

  init = function()
    -- Windows requires a C compiler for treesitter
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }
    end
  end,

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { -- List of languages to install
        "python", "lua", "vim", "javascript", "html", "css",
        "json", "bash", "c", "cpp", "rust",
        "yaml", "toml", "markdown", "markdown_inline",
      },

      sync_install = false, -- Install languages asynchronously

      auto_install = true, -- Automatically install missing parsers when entering buffer

      highlight = {
        enable = true, -- Enable Treesitter-based syntax highlighting
        additional_vim_regex_highlighting = false, -- Disable standard Vim syntax highlighting
      },

      indent = {
        enable = true, -- Enable Treesitter-based indentation
      },

      incremental_selection = {
        enable = true, -- Enable incremental selection
        keymaps = {
          init_selection = "<C-space>",   -- Start selection with Ctrl+Space
          node_incremental = "<C-space>", -- Increment to the upper named parent
          scope_incremental = false,      -- Disable scope incremental
          node_decremental = "<bs>",      -- Decrement to the previous node with Backspace
        },
      },

      textobjects = {
        select = {
          enable = true, -- Enable textobject selection
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            ["af"] = "@function.outer", -- Select around function
            ["if"] = "@function.inner", -- Select inside function
            ["ac"] = "@class.outer",    -- Select around class
            ["ic"] = "@class.inner",    -- Select inside class
          },
        },
        move = {
          enable = true, -- Enable textobject movement
          set_jumps = true, -- Set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer", -- Go to next function start
            ["]]"] = "@class.outer",    -- Go to next class start
          },
          goto_next_end = {
            ["]M"] = "@function.outer", -- Go to next function end
            ["]["] = "@class.outer",    -- Go to next class end
          },
          goto_previous_start = {
            ["[m"] = "@function.outer", -- Go to previous function start
            ["[["] = "@class.outer",    -- Go to previous class start
          },
          goto_previous_end = {
            ["[M"] = "@function.outer", -- Go to previous function end
            ["[]"] = "@class.outer",    -- Go to previous class end
          },
        },
      },
    })
  end,
}