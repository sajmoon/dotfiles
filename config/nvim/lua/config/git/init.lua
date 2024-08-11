local M = {}

function M.setup()

  vim.keymap.set('n', '<leader>gj', function()
    return require('gitsigns').next_hunk()
  end,
  { silent = true, noremap = true, desc = "next hunk" })
  vim.keymap.set('n', '<leader>gj', function()
    return require('gitsigns').prev_hunk()
  end,
  { silent = true, noremap = true, desc = "prev hunk" })

vim.keymap.set('n', '<leader>gb', "<cmd>Telescope git_branches<CR>", { desc = "checkout branch" })
vim.keymap.set('n', '<leader>go', "<cmd>Telescope git_status<CR>", { desc = "open changed file" })
vim.keymap.set('n', '<leader>gc', "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })
vim.keymap.set('n', '<leader>gh', "<cmd>0Gclog<CR>", { desc = "File history" })
vim.keymap.set('n', '<leader>gL', "<cmd>Gclog<CR>", { desc = "Git log information" })
  vim.keymap.set('n', '<leader>gm', "<cmd>Magit<CR>", { desc = "Magit"})
end

return M
