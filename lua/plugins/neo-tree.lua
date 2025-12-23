-- Neo-tree File Explorer

return {
  enabled = true,
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself

  keys = {
    { "<leader>e", ":Neotree float toggle <CR>", desc = "Toggle float Neo-tree" },
    { "<leader>E", ":Neotree left toggle <CR>", desc = "Toggle left Neo-tree" }
  },
  
  opts = {
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded", -- Border style for floating windows
    enable_git_status = true, -- Enable git status integration
    enable_diagnostics = true, -- Enable diagnostics integration
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- File types that Neo-tree will not replace when opening files

    default_component_configs = {
      container = {
        enable_character_fade = true, -- Enable character fade for long names
      },
      indent = {
        indent_size = 2, -- Size of each indent
        padding = 1, -- Padding on the left side
        with_markers = true, -- Show indent markers
        indent_marker = "│", -- Marker for indent levels
        last_indent_marker = "└", -- Marker for the last indent level
        highlight = "NeoTreeIndentMarker", -- Highlight group for indent markers
        with_expanders = true,  -- Show expanders for folders
        expander_collapsed = "", -- Icon for collapsed folders
        expander_expanded = "", -- Icon for expanded folders
        expander_highlight = "NeoTreeExpander", -- Highlight group for expanders
      },
      icon = {
        folder_closed = "", -- Icon for closed folders
        folder_open = "", -- Icon for open folders
        folder_empty = "ﰊ", -- Icon for empty folders
        default = "", -- Default file icon
      },
      modified = {
        symbol = "[+]", -- Symbol for modified files
        highlight = "NeoTreeModified", -- Highlight group for modified symbol
      },
      name = {
        trailing_slash = false, -- Do not add a trailing slash to folder names
        use_git_status_colors = true, -- Use git status colors for file names
        highlight = "NeoTreeFileName", -- Highlight group for file names
      },
      git_status = {
        symbols = {
          added     = "✚", -- Symbol for added files
          modified  = "", -- Symbol for modified files
          deleted   = "✖", -- Symbol for deleted files
          renamed   = "", -- Symbol for renamed files
          untracked = "", -- Symbol for untracked files
          ignored   = "", -- Symbol for ignored files
          unstaged  = "", -- Symbol for unstaged files
          staged    = "", -- Symbol for staged files
          conflict  = "", -- Symbol for conflicted files
        },
        window = {
          position = "float", -- Position of the git status window
          mappings = {
            ["A"] = "git_add_all", -- 'A' to add all files
            ["gu"] = "git_unstage_file", -- 'gu' to unstage file
            ["gU"] = "git_undo_last_commit", -- 'gU' to undo last commit
            ["ga"] = "git_add_file", -- 'ga' to add file
            ["grm"] = "git_remove_file", -- 'grm' to remove file
            ["gr"] = "git_revert_file", -- 'gr' to revert file
            ["gc"] = "git_commit", -- 'gc' to commit
            ["gp"] = "git_push",  -- 'gp' to push commits
            ["gg"] = "git_commit_and_push", -- 'gg' to commit and push
            ["o"] = { -- 'o' to order by
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false }, -- 'oc' to order by created
            ["od"] = { "order_by_diagnostics", nowait = false }, -- 'od' to order by diagnostics
            ["om"] = { "order_by_modified", nowait = false }, -- 'om' to order by modified
            ["on"] = { "order_by_name", nowait = false }, -- 'on' to order by name
            ["os"] = { "order_by_size", nowait = false }, -- 'os' to order by size
            ["ot"] = { "order_by_type", nowait = false }, -- 'ot' to order by type
          }
        },
      },
      window = {
        position = "left", -- Position of the Neo-tree window
        width = 40, -- Width of the Neo-tree window
        mapping_options = {
          noremap = true, -- Non-recursive mappings
          nowait = true, -- Do not wait for more key sequences
        },
        mappings = {
          ["<cr>"] = "open", -- Enter to open file or folder
          ["s"] = "open_split", -- 's' to open in split
          ["v"] = "open_vsplit", -- 'v' to open in vertical split
          ["t"] = "open_tabnew", -- 't' to open in new tab
          ["a"] = { "add", config = { show_path = "relative" } }, -- 'a' to add file with relative path
          ["d"] = "delete", -- 'd' to delete file
          ["r"] = "rename", -- 'r' to rename file
          ["y"] = "copy_to_clipboard", -- 'y' to copy file to clipboard
          ["x"] = "cut_to_clipboard", -- 'x' to cut file to clipboard
          ["p"] = "paste_from_clipboard", -- 'p' to paste from clipboard
          ["R"] = "refresh", -- 'R' to refresh the tree
          ["H"] = "toggle_hidden", -- 'H' to toggle hidden files
          ["."] = "set_root", -- '.' to set root to current folder
        },
      },
      filesystem = {
        filtered_items = {
          visible = false, -- Do not show filtered items by default
        hide_dotfiles = false, -- Do not hide dotfiles
          hide_gitignored = false, -- Do not hide gitignored files
          hide_by_name = { ".git", "node_modules", "__pycache__" }, -- Hide these specific files/folders
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every time
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      },
    },
  }
}
