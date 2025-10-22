-- LSP Configuration

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    
    config = function()
      -- Diagnostic configuration
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = true,
        update_in_insert = false,
        
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      })
      
      -- LSP keybindings on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          
          map('gd', require('telescope.builtin').lsp_definitions, 'Go to Definition')
          map('gr', require('telescope.builtin').lsp_references, 'Go to References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Go to Implementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
          map('<leader>lr', vim.lsp.buf.rename, 'Rename')
          map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
          
          map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
          map('<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
        end,
      })
      
      -- LSP capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" }
              },
              diagnostics = { globals = { 'vim' } },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {},
        ts_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
      }
      
      -- Setup servers via mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              'force', {}, capabilities, server.capabilities or {}
            )
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}