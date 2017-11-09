"""""""""""""""""""""""""
" General Setting
""""""""""""""""""""""""" "

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
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set colorcolumn=80
set wildmode=list:longest
nnoremap j gj
nnoremap k gk
" set clipboard=unnamedplus
set clipboard=unnamed

" Tab Setting
set expandtab
set tabstop=2
set shiftwidth=2

" Search Setting
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set tags=./tags
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" KeyBind
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
nnoremap == gg=G''
nmap n nzz
nmap N Nzz
noremap <C-y> "+y

" Arrow invalid
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>


autocmd QuickFixCmdPost *grep* cwindow
"""""""""""""""""""""""""
" Vim Plugins Setup(dein.vim)
"""""""""""""""""""""""""

" Install directory
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" if it is not installed
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" plugin setting
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " setting save
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"""""""""""""""""""""""""
" Unite.vim
"""""""""""""""""""""""""
let g:unite_enable_start_insert=0

" KeyMap
noremap <C-l> :Unite buffer<CR>
noremap <C-n> :Unite -buffer-name=file file<CR>
noremap <C-z> :Unite file_mru<CR>
nnoremap <silent> sg  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> scg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> sr  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
"""""""""""""""""""""""""
" ColorScheme
"""""""""""""""""""""""""
colorscheme jellybeans
syntax on
" set t_Co=256
" let g:molokai_original = 1
" let g:rehash256 = 1
" set background=dark

"""""""""""""""""""""""""
" IndentGuide
"""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2

" IndentColor
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray

let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1


"""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""
" autocmd vimenter * NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks=1

" KeyMap
nnoremap <silent><C-e> :NERDTreeToggle<CR>

if argc() == 0
  let g:nerdtree_tabs_open_on_console_startup = 1
end

"""""""""""""""""""""""""
" Neocomplete
"""""""""""""""""""""""""
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"""""""""""""""""""""""""
" Rsense
"""""""""""""""""""""""""
let g:rsenseHome = expand("/home/tksugar/.rbenv/shims/rsense")
let g:rsenseUseOmniFunc = 1

"""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
" let g:syntastic_ruby_checkers = ['rubocop'] }

"""""""""""""""""""""""""
" Ctags
"""""""""""""""""""""""""
nnoremap <C-j> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-]> g<C-]>

let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -f .tags -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=.tags
set tags+=.Gemfile.lock.tags

"""""""""""""""""""""""""
" Vim Airline
"""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
set laststatus=2
set showtabline=2
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

"""""""""""""""""""""""""
" Vim Misc
"""""""""""""""""""""""""
" session保存ファイル名
let g:session_default_name = '.default.session'
" session保持ファイルの拡張子
let g:session_extension = '.vim'
" session保存ディレクトリを現在のディレクトリにする
let g:session_directory = getcwd()
" vim終了時に自動保存しない
let g:session_autosave = 'no'
" 引数なしでvimを起動した時にセッションを復元しない
let g:session_autoload = 'no'
" 1分間に1回自動保存をしない(する場合は1)
let g:session_autosave_periodic = 1

function! s:save_session(...)
  if a:0
    let session_name = a:1
  else
    " fugitive.vimの機能を使っているのはブランチ名を取得する部分のみ
    " substitute(system('git rev-parse --abbrev-ref HEAD'), '\n', '', 'g')などで代替可能
    let session_name = fugitive#head()
  end

  if strlen(session_name)
    execute 'SaveSession .'.session_name.'.session'
  else
    SaveSession
  endif
endfunction

function! s:load_session(...)
  if a:0
    let session_name = a:1
  else
    let session_name = fugitive#head()
  end

  if strlen(session_name)
    execute 'OpenSession .'.session_name.'.session'
  else
    execute
    'OpenSession '.g:session_default_name
  endif
endfunction

command! -nargs=? SaveS call s:save_session(<f-args>)
command! -nargs=? LoadS call s:load_session(<f-args>)
