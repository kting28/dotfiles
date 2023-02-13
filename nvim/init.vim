call plug#begin('~/.vim/plugged')
" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" LSP
Plug 'neovim/nvim-lspconfig'
" LSP - completion
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' 
" LSP - snippets
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
" LSP - misc
Plug 'folke/trouble.nvim'
Plug 'seblj/nvim-echo-diagnostics'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'rmagatti/goto-preview'
Plug 'simrat39/rust-tools.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
" Style & UI
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'goolord/alpha-nvim'
" Utils
Plug 'folke/which-key.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'tpope/vim-vinegar'
Plug 'akinsho/toggleterm.nvim'
" Dev 
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'chrisbra/csv.vim'
Plug 'ahmedkhalf/project.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'azabiong/vim-highlighter'
Plug 'numToStr/Comment.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'simrat39/symbols-outline.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'dnlhc/glance.nvim'
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

let g:netrw_liststyle=3
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>

map <silent> <leader><cr> :noh<cr>

augroup FugitiveBehavior
  autocmd!
  autocmd User FugitiveStageBlob setlocal readonly nomodifiable noswapfile
augroup END

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

lua require('cfg')

