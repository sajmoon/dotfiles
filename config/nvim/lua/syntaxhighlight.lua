-- nvim-treesitter 'main' branch + Neovim's built-in treesitter (Neovim 0.11+).
-- Highlighting itself is provided by Neovim core (vim.treesitter.start); this
-- plugin's job is to install parsers/queries for languages Neovim doesn't bundle.

local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  return
end

ts.setup {}

-- Parsers for the languages you actually use. Bundled parsers (lua, vim,
-- vimdoc, markdown, bash, c, query, ...) already work without installing
-- anything. The rest must be compiled, so only attempt installation when a C
-- compiler is present — otherwise treesitter errors once per parser. Install
-- build-essential to enable the rest.
local languages = {
  -- Core languages
  "javascript",
  "typescript",
  "tsx",
  "jsdoc",

  -- Backend/Scripting
  "bash",
  "lua",

  -- Config/Data formats
  "json",
  "yaml",
  "toml",

  -- Documentation
  "markdown",
  "markdown_inline",

  -- Version control
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "gitattributes",

  -- IaC
  "terraform",
  "hcl",

  -- Vim
  "vim",
  "vimdoc",

  -- Web/Markup
  "html",
  "css",

  -- Query language
  "query",
}

local has_compiler = vim.fn.executable("cc") == 1
  or vim.fn.executable("gcc") == 1
  or vim.fn.executable("clang") == 1

if has_compiler then
  -- Async; a no-op for parsers that are already installed.
  ts.install(languages)
end

-- Turn on treesitter highlighting for any buffer whose filetype has a parser
-- available (bundled or installed). pcall makes it a no-op for filetypes with
-- no parser, leaving Vim's regex syntax in place. c/rust stay on regex syntax.
local disable = { c = true, rust = true }
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if disable[vim.bo[args.buf].filetype] then
      return
    end
    pcall(vim.treesitter.start, args.buf)
  end,
})
