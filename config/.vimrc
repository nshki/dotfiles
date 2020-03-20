if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

syntax on
colorscheme palenight

if (has('termguicolors'))
  set termguicolors
endif

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:lightline = {
      \   'colorscheme': 'palenight',
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['gitbranch', 'readonly', 'filename', 'modified']
      \     ]
      \   },
      \   'component_function': { 'gitbranch': 'fugitive#head' }
      \ }
let g:lightline.tabline = { 'left': [['buffers']], 'right': [['close']] }
let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
let g:lightline.component_type = { 'buffers': 'tabsel' }
let g:lightline#bufferline#show_number = 1
let g:tmuxline_theme = 'lightline_visual'
let g:tmuxline_preset = 'minimal'
let g:tmuxline_powerline_separators = 0
let NERDTreeShowHidden = 1

set background=dark
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set showtabline=2
set nowrap
set expandtab
set list
set number
set relativenumber
set foldmethod=syntax
set foldlevel=1
set colorcolumn=80
set lcs+=space:· " Show spaces as dots
set backspace=2 " Make backspace behave like most editors
