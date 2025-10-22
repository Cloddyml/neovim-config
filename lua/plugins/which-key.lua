-- Keybinding Hints

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  
  opts = {
    preset = "modern",
    delay = 300,
    
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
    
    triggers = {
      { "<auto>", mode = "nixsotc" },
    },
  },
  
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    wk.add({
      -- Find
      { "<leader>f", group = "Find" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fr", desc = "Recent Files" },
      { "<leader>fw", desc = "Find Text" },
      { "<leader>fb", desc = "Buffers" },
      
      -- Git
      { "<leader>g", group = "Git" },
      { "<leader>gb", desc = "Branches" },
      { "<leader>gc", desc = "Commits" },
      { "<leader>gs", desc = "Status" },
      { "<leader>gg", desc = "LazyGit" },
      
      -- Git Hunks
      { "<leader>h", group = "Git Hunks" },
      { "<leader>hs", desc = "Stage Hunk" },
      { "<leader>hr", desc = "Reset Hunk" },
      { "<leader>hp", desc = "Preview Hunk" },
      
      -- LSP
      { "<leader>l", group = "LSP" },
      { "<leader>la", desc = "Code Action" },
      { "<leader>lf", desc = "Format" },
      { "<leader>lr", desc = "Rename" },
      { "<leader>ls", desc = "Symbols" },
      
      -- Terminal
      { "<leader>t", group = "Terminal" },
      { "<leader>tf", desc = "Float Terminal" },
      { "<leader>th", desc = "Horizontal Terminal" },
      { "<leader>tv", desc = "Vertical Terminal" },
      
      -- Buffer
      { "<leader>b", group = "Buffer" },
      { "<leader>bp", desc = "Pick Buffer" },
      
      -- Close
      { "<leader>x", group = "Close" },
      { "<leader>xx", desc = "Close Buffer" },
      { "<leader>xr", desc = "Close Right" },
      { "<leader>xl", desc = "Close Left" },
      
      -- Files
      { "<leader>e", desc = "Explorer Float" },
      { "<leader>w", desc = "Save" },
      { "<leader>q", desc = "Quit" },
    })
  end,
}