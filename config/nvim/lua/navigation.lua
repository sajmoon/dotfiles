local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup { keys = 'etovxqpdygfblzhckisuran' }

vim.keymap.set('n', '<leader>s', function()
  return require('hop').hint_words()
end,
{ silent = true, noremap = true, desc = "nvim-hop char2" })
