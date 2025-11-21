vim.cmd("colorscheme gruvbox")
vim.o.termguicolors = true

require('lualine').setup({
  options = {
    theme = 'gruvbox',
    icons_enabled = false,
  }
})

-- Disable devicons globally
require('nvim-web-devicons').setup({
  override = {},
  default = true,
})
require('colorizer').setup()
