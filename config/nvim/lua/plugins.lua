vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'lewis6991/spellsitter.nvim' }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run =  "make" }

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer', "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      'quangnguyen30192/cmp-nvim-ultisnips', 'onsails/lspkind-nvim',
      'hrsh7th/cmp-path', 'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    }
  }

  -- Navigate with hop
  use { 'phaazon/hop.nvim', branch = 'v2' }
  use { 'itchyny/vim-cursorword' }

  -- Snippets
  use { 'SirVer/ultisnips' }

  -- Look'n'feel
  use { 'folke/tokyonight.nvim' }
  use { 'feline-nvim/feline.nvim' }
  use { 'flazz/vim-colorschemes' }
  use { 'norcalli/nvim-colorizer.lua' }

  -- Utils
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-vinegar' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-eunuch' }
  use { 'dockyard/vim-easydir' }

  -- Gitstuffs
  use { 'lewis6991/gitsigns.nvim', }
  use { 'jreybert/vimagit' }
  use { "tpope/vim-fugitive" }

  -- Testrunner
  use { 'janko-m/vim-test' }

  use { "folke/which-key.nvim" }

end)
