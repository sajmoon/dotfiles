if &compatible
  set nocompatible
endif
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " Utility plugins
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/echodoc')

  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-dispatch')
  " call dein#add('ervandew/supertab') " Perform autocomplete on tab in insert mode
  call dein#add('dockyard/vim-easydir') " Create directories

  call dein#add('junegunn/limelight.vim')
  call dein#add('junegunn/goyo.vim')

  " Git stuffs
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Look'n'feel
  call dein#add('flazz/vim-colorschemes')
  call dein#add('itchyny/lightline.vim')

  " Snippets
  call dein#add('SirVer/ultisnips')
	call dein#add('honza/vim-snippets') " A Snippets library

  " Testrunner
  call dein#add('janko-m/vim-test')

  " Support for languages
  call dein#add('sheerun/vim-polyglot')

  call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': './install.sh',
    \ })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" if dein#check_install()
"   call dein#install()
" endif

set shell=bash
set hidden
set showtabline=0
set noshowmode

set termguicolors

" Theme vim
" Some gooed colorschems: molokai, solarized seoul256
colorscheme seoul256

set background=dark

" Leader - Use \

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
set scrolloff=3   " always show one line above and below
set encoding=utf-8
set pastetoggle=<F2>
set mouse=a
set lazyredraw " only redraw when vim has too

set ignorecase

" Teach vim different fileextensions
au BufRead,BufNewFile *.md set filetype=markdown

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

" Show linenumbers by default
set number

" toggle relative numbers when
" switch mode
" autocmd InsertEnter * :call SetNormalLineNumbers()
" autocmd InsertLeave * :call SetRelativeLineNumbers()

" Language specific config

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Snippets
let g:UltiSnipsSnippetsDir="~/.vim/snips"

" Language server
    "\ 'javascript': ['javascript-typescript-langserver'],
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['/Users/simon/.asdf/shims/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['/Users/simon/.asdf/shims/javascript-typescript-stdio']
\ }

let g:LanguageClient_autoStart = 1 " Autostart language server
let g:LanguageClient_autoStop = 0 " Keep running after closing vim

" Code completion (Deoplete)
" :help deoplete-options for configuration options
"
" Enable deoplete at start up
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('sources', {
      \ '_': ['buffer'],
      \ 'javascript': ['LanguageClient', 'ultisnips'],
      \ 'ruby': ['ultisnips'],
\})

" Disable the candidates in Comment/String syntaxes.
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'ultisnips']
let g:deoplete#sources.javascript = ['LanguageClient', 'ultisnips']

" configuration
" set completeopt=longest,menuone,preview

let g:jsx_ext_required = 0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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

" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>

" fzf
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" vim-test
" t Ctrl+n
nmap <silent> t<C-n> :TestNearest -strategy=neovim<CR>
" t Ctrl+f
nmap <silent> t<C-f> :TestFile<CR>
" t Ctrl+s
nmap <silent> t<C-s> :TestSuite<CR>
" t Ctrl+l
nmap <silent> t<C-l> :TestLast<CR>
" t Ctrl+g
nmap <silent> t<C-g> :TestVisit<CR>

" Goyo and Limelight
" Distaction free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Git and git commands Gutter 
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk<Paste>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Enable per project .vimrc file
set exrc
set secure
