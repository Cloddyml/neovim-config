-- GitHub Copilot Integration

return {
  -- Core Copilot plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",

    opts = {
      suggestion = {
        enabled = false, -- Disable inline suggestions (we'll use cmp instead)
      },
      panel = {
        enabled = false, -- Disable panel (we'll use cmp instead)
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },

  -- Copilot CMP Source
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },

    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
