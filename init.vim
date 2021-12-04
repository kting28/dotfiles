call plug#begin('~/.vim/plugged')
" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp' 
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
Plug 'folke/trouble.nvim'
Plug 'seblj/nvim-echo-diagnostics'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
" Style & UI
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'folke/lsp-colors.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/which-key.nvim'
Plug 'akinsho/bufferline.nvim'
" Dev 
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'akinsho/toggleterm.nvim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'chrisbra/csv.vim'
" Misc
Plug 'antoinemadec/FixCursorHold.nvim'
call plug#end()

set termguicolors
set background=dark
let cursorhold_updatetime = 100
set mouse=nv

let mapleader=" "

set scrolloff=7 cmdheight=2 lazyredraw
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set whichwrap+=<,>,h,l
set ignorecase smartcase
set showmatch matchtime=2 timeoutlen=500
set expandtab shiftwidth=2 tabstop=2 smartindent
set number cursorline

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>

augroup FugitiveBehavior
  autocmd!
  autocmd User FugitiveStageBlob setlocal readonly nomodifiable noswapfile
augroup END

lua require('cfg')

