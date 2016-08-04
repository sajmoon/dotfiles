set nocompatible

let s:dein_root = expand('~/.vim/dein')
let s:dein_path = expand(s:dein_root . '/repos/github.com/Shougo/dein.vim')
execute 'set runtimepath^=' . s:dein_path

call dein#begin(s:dein_root)
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neoyank.vim')

  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-surround')

  " git stuffs
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('itchyny/lightline.vim')

  " lazy load on command executed
  call dein#add('scrooloose/nerdtree',
    \{'on_cmd': 'NERDTreeToggle'})

call dein#end()

filetype plugin indent on

set shell=bash
set hidden
set showtabline=0

" Leader
let mapleader = " "

:set t_ut=

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set encoding=utf-8
set pastetoggle=<F2>
set mouse=a
set lazyredraw " only redraw when vim has too

" Teach vim different fileextensions

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.go set filetype=go

" if you forgot to use sudo for some files,
" use :w!!
cmap w!! w !sudo tee % >/dev/null

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

augroup reload_myvimrc
  au!
  au BufWritePost ~/dotfiles/nvimrc,~/dotfiles/vimrc.bundles,~/dotfiles/vimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" highlight current line
set cursorline

" Line Numbers
function! SetNormalLineNumbers()
    set norelativenumber
    set number
    highlight LineNr ctermfg=black
endfunction

function! SetRelativeLineNumbers()
    set relativenumber
    highlight LineNr ctermfg=black
endfunction

function! NumberToggle()
  if(&relativenumber == 1)
    call SetNormalLineNumbers()
  else
    call SetRelativeLineNumbers()
  endif
endfunc

nnoremap <c-n> :call NumberToggle()<cr>

" Defaults
set number

" toggle relative numbers when
" switch mode
" autocmd InsertEnter * :call SetNormalLineNumbers()
" autocmd InsertLeave * :call SetRelativeLineNumbers()

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
  else
      return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
" let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" let g:syntastic_check_on_open = 1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': ['go', 'javascript'] }

nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
let g:syntastic_javascript_checkers = ['eslint']

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Always use vertical diffs
set diffopt+=vertical

" lightline - status bar
set encoding=utf-8
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#statusline()")?fugitive#statusline():""}'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#statusline()") && ""!=fugitive#statusline())'
  \ },
\ }

let g:bufferline_echo = 0

" NERDTree toggle on leader -> t
nmap <silent> <leader>n :NERDTreeToggle<CR>

" Unite
let g:unite_source_history_yank_enable = 1
nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>"
nnoremap <leader>/ :Unite grep:.<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction


" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
