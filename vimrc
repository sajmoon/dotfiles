if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Fuzzy find files and buffers
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-vinegar')
  call dein#add('tpope/vim-eunuch')
  call dein#add('w0rp/ale')
  call dein#add('neomake/neomake')
  call dein#add('dockyard/vim-easydir') " Create directories
  call dein#add('blueyed/vim-diminactive')

  " Utility plugins
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/echodoc')

  call dein#add('tpope/vim-commentary')

  " Focused editing
  call dein#add('junegunn/limelight.vim')
  call dein#add('junegunn/goyo.vim')

  " Git stuffs
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('jreybert/vimagit')

  " Look'n'feel
  call dein#add('flazz/vim-colorschemes')
  call dein#add('itchyny/lightline.vim')

  " Snippets
  call dein#add('SirVer/ultisnips')
 	" call dein#add('honza/vim-snippets') " A Snippets library

  " Testrunner
  call dein#add('janko-m/vim-test')

  " Support for languages
  call dein#add('sheerun/vim-polyglot')
  call dein#add('slashmili/alchemist.vim')

  call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': './install.sh',
    \ })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

language en_US

"set autowrite     " Automatically :write before running commands
set backspace=2   " Backspace deletes like most programs in insert mode
set cursorline
set encoding=utf-8
set expandtab
set hidden
set history=50
set ignorecase
set incsearch     " do incremental searching before hitting enter
set laststatus=2  " Always display the status line
set lazyredraw    " only redraw when vim has too
set mouse=a
set nobackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowritebackup
set pastetoggle=<F2>
set path=**
set ruler         " show the cursor position all the time
set scrolloff=3   " always show some lines above and below
set shell=bash
set shiftround
set shiftwidth=2
set showcmd       " display incomplete commands
set tabstop=2
set termguicolors

" Theme vim
" Some gooed colorschems: molokai, solarized seoul256, neodark
colorscheme neodark
set background=dark

" Teach vim different fileextensions
au BufRead,BufNewFile *.md set filetype=markdown

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

" nnoremap <c-n> :call NumberToggle()<cr>

" Show linenumbers by default
set number

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Better display for messages
set cmdheight=2

" Set spellfile to location that is guaranteed to exist, can be symlinked to
set spellfile=$HOME/.vim-spell-en.utf-8.add
exec 'silent mkspell! ' . &spellfile . '.spl ' . &spellfile

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

" Snippets
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Language server
" \ 'javascript': ['javascript-typescript-stdio'],
let g:LanguageClient_serverCommands = {
      \ 'elixir': ['elixir-ls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'ruby': ['stdio'],
\ }

let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1

" Or map each action separately
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>

" Linting/fixiing
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'elixir': ['mix_format'],
\   'ruby': ['rubocop']
\}

let g:ale_fix_on_save = 0

" Completion (Deoplete)
" :help deoplete-options for configuration options
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)
" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

call deoplete#custom#source('vim', 'mark', '<vim>')
call deoplete#custom#source('LanguageClient', 'mark', '<lang>')
call deoplete#custom#source('tag', 'mark', '<tag>')
call deoplete#custom#source('around', 'mark', '<a>')
call deoplete#custom#source('buffer', 'mark', '<buf>')
call deoplete#custom#source('tmux-complete', 'mark', '<tmux>')
call deoplete#custom#source('syntax', 'mark', '<syntax>')
call deoplete#custom#source('member', 'mark', '<member>')
call deoplete#custom#source('ultisnips', 'mark', '<usnip>')
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

call deoplete#custom#source('LanguageClient', 'rank', 9000)
call deoplete#custom#source('ultisnips', 'rank', 5000)
call deoplete#custom#source('around', 'rank', 2000)
call deoplete#custom#source('buffer', 'rank', 1000)

" configuration
set completeopt=longest,menuone,preview

" lightline - status bar
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \ },
  \ 'component_visible_condition': {
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \ },
  \'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
\ }

" fzf
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

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
