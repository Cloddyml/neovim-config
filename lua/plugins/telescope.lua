-- Telescope Fuzzy Finder

return {
  enable = true,
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  event = "VeryLazy",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    "nvim-tree/nvim-web-devicons",
  },
  
  config = function()
    local keymap = vim.keymap
    local builtin = require('telescope.builtin')
    local telescope = require('telescope').setup{
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        path_display = { "truncate" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        file_ignore_patterns = {
          "node_modules", ".git/", "dist/", "build/", "*.lock",
        },
      },

      pickers = {
        find_files = { theme = "dropdown" },
        git_files = { theme = "dropdown" },
        buffers = { theme = "dropdown" },
        oldfiles = { theme = "dropdown" },
        git_branches = { theme = "dropdown" },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }

    keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files' })
    keymap.set('n', '<leader>fr', builtin.oldfiles, {desc = 'Recent files' })
    keymap.set('n', '<leader>fw', builtin.live_grep, {desc = 'Live grep' })
    keymap.set('n', '<leader>fc', builtin.grep_string, {desc = 'Grep string' })
    keymap.set('n', '<leader>fk', builtin.keymaps, {desc = 'Keymaps' })
    keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = 'Diagnostics' })
    keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {desc = 'Document symbols' })
    keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, {desc = 'Workspace symbols' })

    keymap.set('n', '<leader>gb', builtin.git_branches, {desc = 'Git branches' })
    keymap.set('n', '<leader>gc', builtin.git_commits, {desc = 'Git commits' })
    keymap.set('n', '<leader>gs', builtin.git_status, {desc = 'Git status' })
      
  end,
}