local M = {}

-- Like gf but creates the file if it doesn't exists
local function createFileUnderCursor()
  local filename = vim.fn.expand("<cfile>")
  local current_directory = vim.fn.expand('%:p:h')
  local expanded_filename = current_directory .. '/' .. filename

  vim.cmd("edit" .. expanded_filename)
end

function M.setup()
  vim.keymap.set("n", "<leader>cj", vim.diagnostic.goto_next, { desc = "Next warning" })
  vim.keymap.set("n", "<leader>ck", vim.diagnostic.goto_prev, { desc = "Previous warning" })

  vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist, { desc = "Quickfix - setloclist" })
  vim.keymap.set("n", "gF", createFileUnderCursor, { desc = "Create file under cursor" })

  -- Execute test
  vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
  vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run test file" })
  vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run test suite" })
  vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last suite" })
  vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>", { desc = "Goto last test" })
end

return M
