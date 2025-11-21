local keymap = vim.keymap

-- Go to the beginning and end of current line in insert mode quickly
keymap.set('i', '<C-A>', '<HOME>')
keymap.set('i', '<C-E>', '<END>')

-- Delete the character to the right of the cursor
keymap.set('i', '<C-D>', '<DEL>')

-- Code refactors needed in visual mode
vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false }
)

-- Copy to system clipboard
keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy line to clipboard' })

-- Paste from system clipboard
keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
