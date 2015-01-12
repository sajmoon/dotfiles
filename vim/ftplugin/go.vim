au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

au FileType go au BufWritePre <buffer> Fmt

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au BufWritePost *.go silent! !ctags -R &.

