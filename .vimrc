"===============================================================================
"                                _
"                         __   _(_)_ __ ___  _ __ ___
"                         \ \ / / | '_ ` _ \| '__/ __|
"                          \ V /| | | | | | | | | (__
"                         (_)_/ |_|_| |_| |_|_|  \___|
"
"===============================================================================

call plug#begin('~/.vim/plugged')
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

syntax on
set background=dark
colorscheme hybrid_material

let g:airline_theme = 'hybrid'

set autoindent
set expandtab
set number
set shiftwidth=2

let NERDTreeShowHidden = 1

