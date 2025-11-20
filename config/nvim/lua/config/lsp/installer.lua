local M = {}

function M.setup(opts)
  local lsp_zero = require('lsp-zero')
  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr, desc = "References"})
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = bufnr, desc = "Code actions"})
    vim.keymap.set('n', '<leader>cL', '<cmd>lua vim.lsp.buf.codelens.run()<CR>', {buffer = bufnr, desc = "CodeLens action"})
    vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = bufnr, desc = "Rename"})
    vim.keymap.set('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true })<CR>', {buffer = bufnr, desc = "Format file"})

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = bufnr })
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = bufnr })
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = bufnr })
    -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = bufnr })
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = bufnr })
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { buffer = bufnr })

    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('mason').setup({})

  require('mason-lspconfig').setup({
    ensure_installed = {
      -- Core development
      "ts_ls",           -- TypeScript/JavaScript
      "lua_ls",          -- Lua
      "vimls",           -- VimScript

      -- Shell/IaC
      "bashls",          -- Bash
      "terraformls",     -- Terraform

      -- Data formats
      "jsonls",          -- JSON
      "yamlls",          -- YAML

      -- Documentation
      "marksman",        -- Markdown
    },
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    },
  })

end

return M
