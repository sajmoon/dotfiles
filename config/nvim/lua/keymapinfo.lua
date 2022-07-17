-- Define your keymaps as a list of tables like so
-- description is required for them to appear when you search

local wk = require("which-key")
wk.register({
  f = {
    name = "Find", -- optional group name
    f = {
      [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
      "Find files",
    },
    F = {
      "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<CR>",
      "Find files but no ignore",
    },
    b = { "<cmd>Telescope buffers<cr>", "List buffers" },
    g = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
    h = { "<cmd>Telescope help_tags<CR>", "Help" },
    l = { "<cmd>Telescope resume<CR>", "Last Search" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
  },

  c = {
    name = "Code actions",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    r = { '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
    i = { "<cmd>lua vim.lsp.buf.implemntation()<CR>", "Goto implementaion" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Show type definition" },


    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      "Prev Diagnostic",
    },

    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },

    x = {
      "<cmd>Telescope lsp_document_diagnostics<CR>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<CR>",
      "Workspace Diagnostics",
    },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
  },

  t = {
    name = "Test runners",
    n = { ":TestNearest<CR>", "Run nearest test" }, 
    f = { ":TestFile<CR>", "Run test file" },
    s = { ":TestSuite<CR>", "Run test suite" },
    l = { ":TestLast<CR>", "Run last test" },
    g = { ":TestVisit<CR>", "Goto test" },
  },
  g = {
    name = "Git",
    h = { "<cmd>0Gclog<CR>", "File history" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    l = { "<cmd>G blame<CR>", "Git Blame Information" },
    L = { "<cmd>Gclog<CR>", "Git Log Information" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<cmd>lua require('user.utils.diff')()<CR>",
      "Diff With",
    },
    m = { "<cmd>Magit<CR>", "Magit - Commit stuff" },
  },
    p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    S = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },
}, { prefix = "<leader>" })
