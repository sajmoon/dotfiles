vim.cmd("colorscheme gruvbox")
vim.o.termguicolors = true

require('lualine').setup({
  options = {
    theme = 'gruvbox',
    icons_enabled = true,
  }
})
require('colorizer').setup()
