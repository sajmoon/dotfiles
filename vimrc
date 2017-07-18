if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim

let s:dein_root = expand('~/.vim/dein')
let s:dein_path = expand(s:dein_root . '/repos/github.com/Shougo/dein.vim')
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.vim/dein')
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('neomake/neomake')

  " Utility plugins
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('sbdchd/neoformat')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('itchyny/lightline.vim')
  call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
  call dein#add('tpope/vim-surround')
  call dein#add('ervandew/supertab') " Perform autocomplete on tab in insert mode

  call dein#add('xolox/vim-misc')
  call dein#add('xolox/vim-easytags')

  " Support for language packs
  call dein#add('sheerun/vim-polyglot')

  " Elixir stuff
  call dein#add('slashmili/alchemist.vim')

  " Snippets
  call dein#add('SirVer/ultisnips')

  " Javascript
  call dein#add('carlitux/deoplete-ternjs', { 'build': { 'mac': 'npm install -g tern', 'unix': 'npm install -g tern' }})

  " Git stuffs
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Create directories
  call dein#add('dockyard/vim-easydir')
call dein#end()

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

set shell=bash
set hidden
set showtabline=0
set termguicolors

" Leader
let mapleader = " "

set path=**
set wildmenu
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching before hitting enter
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set scrolloff=1   " always show one line above and below
set encoding=utf-8
set pastetoggle=<F2>
set mouse=a
set lazyredraw " only redraw when vim has too

command! MakeTags !ctags -Re --exclude=public/assets --exclude=node_modules --exclude=vendor/assets/bower --exclude=*.js .
command! MakeTagsJs !find ./web/. -type f -iregex ".*\.js$" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags

" Teach vim different fileextensions
au BufRead,BufNewFile *.md set filetype=markdown

" Messy .es6 filename should be javascript
autocmd BufNewFile,BufRead *.es6 set syntax=javascript

" if you forgot to use sudo for some files,
" use :w!!
cmap w!! w !sudo tee % >/dev/null

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

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

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Snippets
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]

" completion (Deoplete)
" Enable deoplete at start up
let g:deoplete#enable_at_startup = 1

" configuration
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:deoplete#sources['javascript.js'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ["--persistent"]

augroup omnifuncs
  autocmd!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end

" tern
let g:tern#filetypes = [
      \ 'jsx',
      \ 'javascript.jsx'
      \ ]
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Configre neoMake
" Run Neomake on save
autocmd! BufWritePost,BufEnter * Neomake

let g:neomake_javascript_enabled_makers = ['eslint_d']

" NeoFormat
let g:neoformat_run_all_formatters = 1

" Javascript
let g:neoformat_enabled_javascript = ['eslint']

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

" fzf
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
