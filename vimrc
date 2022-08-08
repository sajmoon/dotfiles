" syntax on

" set backspace=2   " Backspace deletes like most programs in insert mode
" set encoding=utf-8
" set incsearch     " do incremental searching before hitting enter
" set nobackup
" set nowritebackup
" set pastetoggle=<F2>
" set path=**
" set ruler         " show the cursor position all the time
" set shell=fish
" set shiftround
" set showcmd       " display incomplete commands

" " Better display for messages
" set cmdheight=2

" augroup vimrcEx
"   autocmd!

"   " When editing a file, always jump to the last known cursor position.
"   " Don't do it for commit messages, when the position is invalid, or when
"   " inside an event handler (happens when dropping a file on gvim).
"   autocmd BufReadPost *
"     \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal g`\"" |
"     \ endif

"   " Automatically wrap at 72 characters and spell check git commit messages
"   autocmd FileType gitcommit setlocal textwidth=72
"   autocmd FileType gitcommit setlocal spell

"   " Allow stylesheets to autocomplete hyphenated words
"   autocmd FileType css,scss,sass setlocal iskeyword+=-
" augroup END


" " Set spellfile to location that is guaranteed to exist, can be symlinked to
" set spellfile=$HOME/.vim-spell-en.utf-8.add
" exec 'silent mkspell! ' . &spellfile . '.spl ' . &spellfile
