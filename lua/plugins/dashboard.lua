-- Dashboard Startup Screen

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  opts = function()
    local logo = [[
    ██████╗ ██████╗ ██╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██████╗ 
   ██╔════╝██╔═══██╗██║   ██║██╔════╝ ██║   ██║██╔══██╗██╔══██╗
   ██║     ██║   ██║██║   ██║██║  ███╗██║   ██║███████║██████╔╝
   ██║     ██║   ██║██║   ██║██║   ██║██║   ██║██╔══██║██╔══██╗
   ╚██████╗╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║
    ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══╝  ╚═╝
    ]]
    
    logo = string.rep("\n", 8) .. logo .. "\n\n"
    
    return {
      theme = "doom",
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { icon = '󰈞  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
          { icon = '󰋚  ', desc = 'Recent Files', key = 'r', action = 'Telescope oldfiles' },
          { icon = '󰱼  ', desc = 'Find Text', key = 'w', action = 'Telescope live_grep' },
          { icon = '󰙅  ', desc = 'File Explorer', key = 'e', action = 'Neotree float' },
          { icon = '󰒓  ', desc = 'Config', key = 'c', action = function()
            vim.cmd('cd ~/.config/nvim')
            require('telescope.builtin').find_files()
          end },
          { icon = '󰒲  ', desc = 'Lazy', key = 'l', action = 'Lazy' },
          { icon = '󰏗  ', desc = 'LSP', key = 'm', action = 'Mason' },
          { icon = '󰗼  ', desc = 'Quit', key = 'q', action = 'qa' },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          return {
            "",
            "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }
  end,
}