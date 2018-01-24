" Automatically wrap at 80 characters for Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile *.md setlocal spell

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
