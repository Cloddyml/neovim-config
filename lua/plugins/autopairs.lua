-- Auto Pairs

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  
  opts = {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
    },
  },
  
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)
    
    -- CMP integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    
    -- Space between brackets
    local Rule = require("nvim-autopairs.rule")
    npairs.add_rules({
      Rule(" ", " ")
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end),
    })
  end,
}