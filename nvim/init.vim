set termguicolors
set background=dark
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

" Clear selections with leader<cr>
map <silent> <leader><cr> :noh<cr>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

lua require('cfg')

