set nocompatible
call pathogen#infect()

syntax on
filetype plugin indent on

set number
set ruler
set nowrap
set encoding=utf-8

set tabstop=2
set shiftwidth=2
set softtabstop=2

set expandtab
set incsearch
set ignorecase
set showmatch
set smartcase

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile {*.json} set ft=javascript
au BufRead,BufNewFile {*.txt} call s:setupWrapping()

" ignore these files when completing names and in Ex
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam
" set of file name suffixes that will be given a lower priority when it comes to matching wildcards
set suffixes+=.old

set guifont=Monospace\ 8

set backspace=indent,eol,start

color desert

