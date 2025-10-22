-- Autocompletion with nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
  },
  
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    
    cmp.setup({
      -- Use native vim.snippet
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({ border = "rounded" }),
      },
      
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'buffer',   priority = 500 },
        { name = 'path',     priority = 250 },
      }),
      
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          menu = {
            nvim_lsp = "[LSP]",
            buffer   = "[Buf]",
            path     = "[Path]",
            cmdline  = "[Cmd]",
          },
        }),
      },
      
      experimental = {
        ghost_text = true,
      },
    })
    
    -- Cmdline completion
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {{ name = 'buffer' }}
    })
    
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        {{ name = 'path' }},
        {{ name = 'cmdline' }}
      ),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
  end,
}