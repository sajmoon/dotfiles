local M = {}

function M.setup()
  -- Better diagnostic configuration
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●',
      source = "if_many",
    },
    float = {
      source = "always",
      border = "rounded",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Better diagnostic signs
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local opts = {}

  require("config.lsp.installer").setup(opts)
  require("config.lsp.null-ls").setup(opts)
end

return M
