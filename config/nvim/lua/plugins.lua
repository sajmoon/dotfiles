local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Look'n'feel
  -- 'folke/tokyonight.nvim',
  { "ellisonleao/gruvbox.nvim" },
  'feline-nvim/feline.nvim',
  -- 'flazz/vim-colorschemes',
  'norcalli/nvim-colorizer.lua',

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { "tree-sitter/tree-sitter-typescript" },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  -- add telescope-fzf-native
  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --     end,
  --   },
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'neovim/nvim-lspconfig', "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      'onsails/lspkind-nvim', 'hrsh7th/cmp-path', 'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    }
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },

  {
    "nvimtools/none-ls.nvim",
  }, -- for formatters and linters
  { "folke/trouble.nvim", enabled = true },

  -- Navigate with hop
  { 'phaazon/hop.nvim', branch = 'v2' },
  { 'itchyny/vim-cursorword' },

  -- Utils
  { 'tpope/vim-commentary' },
  { 'tpope/vim-vinegar' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-eunuch' },
  { 'dockyard/vim-easydir' },

  -- keybindings
  { "folke/which-key.nvim" },

  -- Gitstuffs
  { 'lewis6991/gitsigns.nvim', },
  { 'jreybert/vimagit' },
  { "tpope/vim-fugitive" },

  -- Testrunner
  { 'janko-m/vim-test' },


  -- code refactors
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
})


  -- Debugger
  -- use {
  --   "williamboman/mason.nvim",
  --   "mfussenegger/nvim-dap",
  --   "jay-babu/mason-nvim-dap.nvim",
-- }

  -- Snippets
  -- use { 'SirVer/ultisnips' }

  -- Look'n'feel
  --use { 'folke/tokyonight.nvim' }
  --use { 'feline-nvim/feline.nvim' }
  --use { 'flazz/vim-colorschemes' }
  --use { 'norcalli/nvim-colorizer.lua' }

 -- copilot
  -- use { 'zbirenbaum/copilot.lua' }
  -- use { 'zbirenbaum/copilot-cmp' }

  -- Code
  --use {
  --  "ThePrimeagen/refactoring.nvim",
  --  requires = {
  --    {"nvim-lua/plenary.nvim"},
  --    {"nvim-treesitter/nvim-treesitter"}
  --  }
 -- }


  -- Testrunner
  --use { 'janko-m/vim-test' }


--end)
