-- Markdown-specific settings

-- Disable concealing of markdown syntax (*, _, etc.)
vim.opt_local.conceallevel = 0

-- Wrap text at 80 characters for readability
vim.opt_local.textwidth = 80

-- Enable soft wrapping
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Spell check for markdown, but not in URLs or code blocks
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'

-- Exclude URLs, code blocks, and inline code from spell checking
vim.cmd([[
  syn match markdownUrl `\%(https\?\|ftp\):\/\/[[:alnum:]%\/_#.-]*` contains=@NoSpell
  syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" contains=@NoSpell
  syn region markdownCodeBlock start="^\s*```" end="^\s*```" contains=@NoSpell
]])
