-- Smart Comments

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = { enable_autocmd = false },
    },
  },
  
  opts = {
    padding = true,
    sticky = true,
    mappings = { basic = true, extra = true },
  },
  
  config = function(_, opts)
    opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    require("Comment").setup(opts)
  end,
}