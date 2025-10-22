-- Terminal Integration

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<cr>", desc = "Vertical terminal" },
  },
  
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    direction = "float",
    float_opts = {
      border = "curved",
      width = function() return math.floor(vim.o.columns * 0.9) end,
      height = function() return math.floor(vim.o.lines * 0.9) end,
    },
  },
  
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- Terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
    
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    
    -- Special terminals
    local Terminal = require('toggleterm.terminal').Terminal
    
    local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
    _G.lazygit_toggle = function() lazygit:toggle() end
    
    vim.keymap.set('n', '<leader>gg', '<cmd>lua lazygit_toggle()<CR>', { desc = "LazyGit" })
  end,
}