if &compatible
  set nocompatible
endif

lua require("plugins");

filetype plugin indent on
syntax on

set autowrite     " Automatically :write before running commands
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
set shell=fish
set shiftround
set shiftwidth=2
set showcmd       " display incomplete commands
set tabstop=2
set updatetime=300
set spell
set number

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Better display for messages
set cmdheight=2

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


" Set spellfile to location that is guaranteed to exist, can be symlinked to
set spellfile=$HOME/.vim-spell-en.utf-8.add
exec 'silent mkspell! ' . &spellfile . '.spl ' . &spellfile

" Set leader to space
let mapleader = " "

lua << EOF
  require("fuzzyfinder")
  require("config.lsp.init").setup()
  require("snippets")
  require("completion")
  require("keymapinfo")
  require("git")

  require("lookandfeel")
  require("syntaxhighlight")
  require("navigation")
EOF

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
