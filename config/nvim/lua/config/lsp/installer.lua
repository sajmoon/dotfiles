local M = {}

function M.setup(opts)

  local present, mason = pcall(require, "mason")
  if not present then
    return
  end
  
  local present, lspconfig = pcall(require, "mason-lspconfig")
  if not present then
    return
  end

  local handlers = {
    function (server_name)
      require("lspconfig")[server_name].setup {}
    end,
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
    end,
  }

  require("mason").setup()
  require("mason-lspconfig").setup()
end

return M
