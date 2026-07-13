local present, cmp = pcall(require, "cmp")
if not present then
   return
end

local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- Supermaven's inline suggestion, accepted from the <Tab> mapping below.
-- Guarded so completion still loads if the plugin is absent.
local ok_sm, supermaven = pcall(require, "supermaven-nvim.completion_preview")

vim.opt.completeopt = "menu,menuone,noselect"

-- Load snippets from SnipMate format
require("luasnip.loaders.from_snipmate").load({ paths = { "~/.config/nvim/snips" } })

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "treesitter" },
    { name = "emoji" },
    { name = "path" },
  }, {
    { name = 'buffer' },
  }),
  view = {
    entries = "native",
  },
  formatting = {
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
    }),
    -- Tab, in priority order: accept Supermaven's inline suggestion → pick the
    -- next cmp item → jump to the next snippet placeholder → plain <Tab>.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if ok_sm and supermaven.has_suggestion and supermaven.has_suggestion() then
        supermaven.on_accept_suggestion()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
