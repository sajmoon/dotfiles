local M = {}

function M.setup(opts)
  local hasMasonConfig, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not hasMasonConfig then
    return
  end

  local lsp_zero = require('lsp-zero')
  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr, desc = "References"})
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = bufnr, desc = "Code actions"})
    vim.keymap.set('n', '<leader>cL', '<cmd>lua vim.lsp.buf.codelens.run()<CR>', {buffer = bufnr, desc = "CodeLens action"})
    vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = bufnr, desc = "Rename"})
    vim.keymap.set('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true })<CR>', {buffer = bufnr, desc = "Format file"})

    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('mason').setup({})

  require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    },
  })

  -- require("mason-lspconfig").setup_handlers {
  --   function (server_name)
  --     lspconfig[server_name].setup {}
  --   end
  --   -- you can override the default handler by providing custom handlers per server
  --   -- ["tsserver"] = function ()
  --   --   lspconfig.tsserver.setup {
  --   --     root_dir = nvim_lsp.util.root_pattern('.git');
  --   --   }
  --   -- end
  --   -- ["lua_ls"] = function ()
  --   --   lspconfig.lua.setup {
  --   --     settings = {
  --   --       Lua = {
  --   --         diagnostics = { 
  --   --           globals = { 'vim', 'use' }
  --   --         }
  --   --       }
  --   --     }
  --   --   }
  --     -- // do something with the nvim-jdtls plugin instead
  --   -- end
  -- }

end

return M
