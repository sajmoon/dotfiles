-- Markdown-specific settings

-- Disable concealing of markdown syntax (*, _, etc.)
vim.opt_local.conceallevel = 0

-- Wrap text at 80 characters for readability
vim.opt_local.textwidth = 80

-- Enable soft wrapping
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Spell check for markdown
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
