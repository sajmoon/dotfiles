-- Define your keymaps as a list of tables like so
-- description is required for them to appear when you search

local wk = require("which-key")
wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
  },
  c = {
    name = "code actions",
  },
  t = {
    name = "test runners",
  },
}, { prefix = "<leader>" })
