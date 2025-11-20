local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-------------------------------------------------------------
---- General
-------------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.swapfile = false                  -- Don't use swapfile
g.mapleader = ' '

-------------------------------------------------------------
---- Neovim UI
-------------------------------------------------------------
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus = 3          -- Set global statusline
opt.scrolloff = 3           -- Show some lines below current line

-------------------------------------------------------------
---- Tabs, indent
-------------------------------------------------------------
opt.expandtab =  true       -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Shift 2 spaces when tab
opt.tabstop = 2             -- 1 tab == 2 spaces
opt.smartindent = true      -- Autoindent new lines

-------------------------------------------------------------
---- Memory, CPU
-------------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 300        -- ms to wait for trigger an event

-------------------------------------------------------------
---- Other
-------------------------------------------------------------
vim.opt.list = true         -- Show some invisible characters

-------------------------------------------------------------
---- Node.js Configuration
-------------------------------------------------------------
-- Force nvim to use a specific Node.js version (bypassing asdf local config)
-- Option 1: Use asdf's global Node.js version
vim.g.node_host_prog = vim.fn.expand('~/.asdf/shims/node')

-- Option 2: Use a specific Node.js version installed via asdf
-- vim.g.node_host_prog = vim.fn.expand('~/.asdf/installs/nodejs/22.0.0/bin/node')

-- Option 3: Use system Node.js (if installed via Homebrew or similar)
-- vim.g.node_host_prog = '/usr/local/bin/node'
