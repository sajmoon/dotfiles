local M = {}

function M.setup(opts)
  local lsp_zero = require('lsp-zero')
  lsp_zero.on_attach(function(client, bufnr)
    -- Custom leader-based bindings (more discoverable than default gr* mappings)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer = bufnr, desc = "Code actions"})
    vim.keymap.set('n', '<leader>cL', vim.lsp.buf.codelens.run, {buffer = bufnr, desc = "CodeLens action"})
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, {buffer = bufnr, desc = "Rename"})
    vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({async = true}) end, {buffer = bufnr, desc = "Format file"})

    -- Override default 'grr' with Telescope for better UX
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr, desc = "References"})

    -- Signature help (if not using lsp_signature.nvim auto-popup)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, {buffer = bufnr, desc = "Signature help"})

    -- Type definition (no default binding)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, {buffer = bufnr, desc = "Type definition"})

    -- Enable inlay hints if supported (nvim 0.10+)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Enable default keybindings: K, gd, gD, gra, grn, grr (overridden above), gri, gO, [d, ]d
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
