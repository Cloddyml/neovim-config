-- Dashboard Startup Screen
return {
  enabled = true,
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    {'nvim-tree/nvim-web-devicons'},
  },
  config = function()
    local logo = [[
    ██████╗ ██████╗ ██╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██████╗ 
   ██╔════╝██╔═══██╗██║   ██║██╔════╝ ██║   ██║██╔══██╗██╔══██╗
   ██║     ██║   ██║██║   ██║██║  ███╗██║   ██║███████║██████╔╝
   ██║     ██║   ██║██║   ██║██║   ██║██║   ██║██╔══██║██╔══██╗
   ╚██████╗╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║
    ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
    ]]
    
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    require('dashboard').setup {
      theme = "doom",
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { icon = '󰈞  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
          { icon = '󰋚  ', desc = 'Recent Files', key = 'r', action = 'Telescope oldfiles' },
          { icon = '󰱼  ', desc = 'Find Text', key = 'w', action = 'Telescope live_grep' },
          { icon = '󰙅  ', desc = 'File Explorer', key = 'e', action = 'Neotree float' },
          { icon = '󰒓  ', desc = 'Config Files', key = 'c', action = function()
            -- TODO
          end },
          { icon = '󰒲  ', desc = 'Lazy', key = 'l', action = 'Lazy' },
          { icon = '󰏗  ', desc = 'LSP Servers (Mason)', key = 'm', action = 'Mason' },
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