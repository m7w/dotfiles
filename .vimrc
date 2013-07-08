set nocompatible

filetype plugin on
filetype indent on

set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set number
set nofoldenable
set foldmethod=indent
set incsearch
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
syntax on
set statusline=%f
set t_Co=256
set statusline=%f\ %m%r\ \[%{&encoding}\]%=%-7(0x%B%)\ \%-14(%l,%c%)\ %P
set laststatus=2

"let moria_style="dark"
"colorscheme moria
colorscheme molokai

execute pathogen#infect()

imap jj <Esc>

let g:slime_target="tmux"
