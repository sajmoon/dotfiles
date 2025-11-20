local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

local sources = {
  -- formatting
  b.formatting.prettierd,
  b.formatting.shfmt,

  -- diagnostics
  b.diagnostics.write_good,
  b.diagnostics.terraform_validate,
  b.diagnostics.todo_comments,
  b.diagnostics.trail_space,

  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.refactoring,

  -- hover
  b.hover.dictionary,

  -- git
  b.code_actions.gitrebase,
}

function M.setup(opts)
  nls.setup {
    debug = false,
    debounce = 150,
    -- save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }
end

return M
