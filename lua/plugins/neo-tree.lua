-- Neo-tree File Explorer

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  
  keys = {
    { "<leader>e", "<cmd>Neotree float reveal<CR>", desc = "Explorer Float" },
    { "<leader>E", "<cmd>Neotree left reveal<CR>", desc = "Explorer Left" },
  },
  
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "*",
      },
      git_status = {
        symbols = {
          added     = "✚",
          modified  = "",
          deleted   = "✖",
          renamed   = "󰁕",
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    },
    
    window = {
      position = "left",
      width = 40,
      mappings = {
        ["<cr>"] = "open",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["a"] = { "add", config = { show_path = "relative" } },
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["R"] = "refresh",
        ["H"] = "toggle_hidden",
        ["."] = "set_root",
      },
    },
    
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { "node_modules", ".git", ".DS_Store" },
      },
    },
  },
}