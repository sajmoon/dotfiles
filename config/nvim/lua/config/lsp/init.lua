local M = {}

function M.setup()
  local opts = {}

  require("config.lsp.installer").setup(opts)
  require("config.lsp.null-ls").setup(opts)
end

return M
