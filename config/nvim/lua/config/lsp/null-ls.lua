local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

local sources = {
  -- formatting
  b.formatting.prettier,
  b.formatting.shfmt,
  b.formatting.fixjson,

  -- diagnostics
  b.diagnostics.write_good,
  b.diagnostics.tsc,

  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- hover
  b.hover.dictionary,
}

function M.setup(opts)
  nls.setup {
    debug = true,
    debounce = 150,
    -- save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }
end

return M
