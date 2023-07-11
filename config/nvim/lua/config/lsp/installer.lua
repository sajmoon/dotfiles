local M = {}

function M.setup(opts)

  local present, mason = pcall(require, "mason")
  if not present then
    return
  end
  
  local present, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not present then
    return
  end

  local present, lspconfig = pcall(require, "lspconfig")
  if not present then
    return
  end

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

  require("mason").setup()
  require("mason-lspconfig").setup()

  require("mason-lspconfig").setup_handlers {
    function (server_name)
      lspconfig[server_name].setup {}
    end,
    -- you can override the default handler by providing custom handlers per server
    ["lua_ls"] = function ()
      lspconfig.lua.setup {
        settings = {
          Lua = {
            diagnostics = { 
              globals = { 'vim', 'use' }
            }
          }
        }
      }
      -- // do something with the nvim-jdtls plugin instead
    end
  }
end

return M
