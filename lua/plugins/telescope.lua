-- Telescope Fuzzy Finder

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
    { '<leader>fw', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Grep string' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Git branches' },
    { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Git commits' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git status' },
    { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document symbols' },
    { '<leader>lS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Workspace symbols' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
  },
  
  opts = {
    defaults = {
      prompt_prefix = "🔍 ",
      selection_caret = "➜ ",
      path_display = { "truncate" },
      
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      
      mappings = {
        i = {
          ["<C-n>"] = "move_selection_next",
          ["<C-p>"] = "move_selection_previous",
          ["<C-c>"] = "close",
          ["<Esc>"] = "close",
          ["<C-q>"] = "send_to_qflist",
        },
        n = {
          ["q"] = "close",
          ["<Esc>"] = "close",
        },
      },
      
      file_ignore_patterns = {
        "node_modules", ".git/", "dist/", "build/", "*.lock",
      },
      
      vimgrep_arguments = {
        "rg", "--color=never", "--no-heading", "--with-filename",
        "--line-number", "--column", "--smart-case", "--hidden", "--glob=!.git/",
      },
    },
    
    pickers = {
      find_files = { theme = "dropdown", hidden = true },
      oldfiles = { theme = "dropdown" },
      buffers = { theme = "dropdown", sort_lastused = true },
    },
  },
}