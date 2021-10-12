if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Color scheme, syntax highlighting, and UI.
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sheerun/vim-polyglot'

" Editing enhancements.
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Ruby and Rails.
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" Search and directory tree.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'

" Misc.
Plug 'editorconfig/editorconfig-vim' " Per-project editor config.
Plug 'janko-m/vim-test'              " Test runner.
Plug 'tpope/vim-dadbod'              " Database client.
Plug 'tpope/vim-fugitive'            " Git wrapper.
call plug#end()

syntax on
colorscheme onedark

if (has('termguicolors'))
  set termguicolors
endif

xmap ga <Plug>(EasyAlign)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:lightline =
  \ {
  \   'colorscheme': 'onedark',
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
let g:coc_global_extensions =
  \ [
  \   'coc-css',
  \   'coc-eslint',
  \   'coc-graphql',
  \   'coc-html',
  \   'coc-html-css-support',
  \   'coc-json',
  \   'coc-solargraph',
  \   'coc-tsserver'
  \ ]
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
set backspace=2  " Make backspace behave like most editors
