require('nvim-treesitter.configs').setup {
  -- Install only parsers for languages you actually use
  ensure_installed = {
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
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "phpdoc" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
