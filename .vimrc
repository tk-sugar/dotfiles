" System Setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" View Setting
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk

" Tab Setting
" set list listchars=tab:\>\-
set expandtab
set tabstop=2
set shiftwidth=2

" Search Setting
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
