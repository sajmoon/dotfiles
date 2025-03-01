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

  -- Navigate with hop
  { 'phaazon/hop.nvim', branch = 'v2' },
  { 'itchyny/vim-cursorword' },
    {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true -- default is false
    }
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

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  --   opts = {
  --     -- add any opts here
  --     provider = "claude", -- Recommend using Claude
  --     auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  --     claude = {
  --       endpoint = "https://api.anthropic.com",
  --       model = "claude-3-5-sonnet-20241022",
  --       temperature = 0,
  --       max_tokens = 4096,
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
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
