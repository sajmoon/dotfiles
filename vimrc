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
  call dein#add('dockyard/vim-easydir') " Create directories
  call dein#add('blueyed/vim-diminactive')

  " Utility plugins
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
  " call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')

  " Testrunner
  call dein#add('janko-m/vim-test')

  " Support for languages
  call dein#add('sheerun/vim-polyglot')
  call dein#add('slashmili/alchemist.vim')

  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

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
set updatetime=300


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

" Set leader to space
let mapleader = " "

" Linting/fixiing
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'elixir': ['mix_format'],
\   'ruby': ['rubocop']
\}

let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_disable_lsp = 1

" Coc completions
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Mappings for CoCList

" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" configuration
set completeopt=longest,menuone,preview

" lightline - status bar
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'filename', 'modified' ] ]
  \ },
  \ 'component': {
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \ },
  \ 'component_visible_condition': {
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \ },
  \'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction',
  \ },
\ }

" fzf
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_tags_command = 'ctags -R'
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
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
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Enable per project .vimrc file
set exrc
set secure
