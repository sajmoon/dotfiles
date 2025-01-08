local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup { keys = 'etovxqpdygfblzhckisuran' }

vim.keymap.set('n', '<leader>s', function()
  return require('hop').hint_words()
end,
{ silent = true, noremap = true, desc = "nvim-hop char2" })

vim.api.nvim_set_keymap('n', '<C-j>', ':Treewalker Down<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':Treewalker Up<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':Treewalker Left<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':Treewalker Right<CR>', { noremap = true })
