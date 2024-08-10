local M = {}

function M.setup(opts)

  local hasMason, mason = pcall(require, "mason")
  if not hasMason then
    return
  end

  local hasMasonConfig, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not hasMasonConfig then
    return
  end

  local hasLspConfig, lspconfig = pcall(require, "lspconfig")
  if not hasLspConfig then
    return
  end

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

  mason.setup()
  mason_lspconfig.setup {
    ensure_installed = { "lua_ls" },
  }

  require("mason-lspconfig").setup_handlers {
    function (server_name)
      lspconfig[server_name].setup {}
    end
    -- you can override the default handler by providing custom handlers per server
    -- ["tsserver"] = function ()
    --   lspconfig.tsserver.setup {
    --     root_dir = nvim_lsp.util.root_pattern('.git');
    --   }
    -- end
    -- ["lua_ls"] = function ()
    --   lspconfig.lua.setup {
    --     settings = {
    --       Lua = {
    --         diagnostics = { 
    --           globals = { 'vim', 'use' }
    --         }
    --       }
    --     }
    --   }
      -- // do something with the nvim-jdtls plugin instead
    -- end
  }
end

return M
