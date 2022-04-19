-- Define your keymaps as a list of tables like so
-- description is required for them to appear when you search

local wk = require("which-key")
wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  },
}, { prefix = "<leader>" })
