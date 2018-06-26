call plug#begin('~/.vim/plugged')
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
call plug#end()

syntax on
colorscheme hybrid_material

let g:airline_theme='hybrid'
let g:airline_powerline_fonts=1
let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git\|tmp'
let g:ctrlp_working_path_mode=''  " Limit CtrlP to starting directory

set background=dark
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nowrap
set expandtab
set list
set number
set colorcolumn=80
set lcs+=space:·    " Show spaces as dots
set backspace=2     " Make backspace behave like most editors

let NERDTreeShowHidden=1

