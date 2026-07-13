local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
  { 'nvim-lualine/lualine.nvim' },
  -- 'flazz/vim-colorschemes',
  -- catgoose fork: norcalli's is unmaintained and calls the removed vim.tbl_flatten.
  'catgoose/nvim-colorizer.lua',

  -- Treesitter
  -- 'main' branch: the only one supporting Neovim 0.11+/0.12 (master tops out
  -- at 0.11). Uses the new API — see syntaxhighlight.lua.
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate' },

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
      'onsails/lspkind-nvim', 'hrsh7th/cmp-path', 'f3fora/cmp-spell', 'hrsh7th/cmp-emoji',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  },

  -- LSP
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  {
    "nvimtools/none-ls.nvim",
  }, -- for formatters and linters
  { "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require("lsp_signature").setup(opts) end
  },

  { 'itchyny/vim-cursorword' },
    {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true -- default is false
    }
  },

  -- Supermaven: AI inline (ghost-text) completion. Acceptance is wired into
  -- the <Tab> mapping in completion.lua, so disable_keymaps stops it grabbing
  -- Tab itself. Run :SupermavenUseFree once to activate the free tier.
  -- NOTE: Supermaven was acquired by Cursor and is being sunset (free Neovim
  -- inference continues for now). Stopgap — the <Tab> chain is engine-agnostic,
  -- so swapping in Copilot / minuet-ai later is a one-plugin change.
  { "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        disable_keymaps = true,
      })
    end,
  },

  -- Utils
  { 'tpope/vim-commentary' },
  { 'tpope/vim-vinegar' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-eunuch' },
  { 'dockyard/vim-easydir' },

  -- keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    icons = { mappings = false }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Gitstuffs
  { 'lewis6991/gitsigns.nvim', },
  { 'jreybert/vimagit' },
  { "tpope/vim-fugitive" },

  -- Testrunner
  { 'janko-m/vim-test' },


  -- Icons for lualine/telescope/trouble (previously pulled in via avante)
  { 'nvim-tree/nvim-web-devicons' },
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
