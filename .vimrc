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
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

syntax on
set background=dark
colorscheme hybrid_material

let g:airline_theme='hybrid'
let g:airline_powerline_fonts=1

set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set colorcolumn=80

let NERDTreeShowHidden=1

