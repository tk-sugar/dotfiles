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
" set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set colorcolumn=80
set wildmode=list:longest
nnoremap j gj
nnoremap k gk
" set clipboard=unnamedplus
set clipboard=unnamed
set backspace=indent,eol,start
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

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
nnoremap sx :qa<CR>
nnoremap sq :tabclose<CR>
nnoremap s0 :tabfirst<CR>
nnoremap s$ :tablast<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
nnoremap == gg=G''
nmap n nzz
nmap N Nzz
noremap <C-y> "+y

" Tab Jump
for n in range(1, 9)
  execute 'nnoremap s'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

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
colorscheme tender
syntax enable
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
autocmd vimenter * NERDTree
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
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

"""""""""""""""""""""""""
" Rsense
"""""""""""""""""""""""""
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

let g:rsenseHome = expand("/Users/tksugar/.rbenv/shims/rsense")
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
set laststatus=2
set showtabline=2
let g:airline_section_a = airline#section#create(['mode','','branch'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:Powerline_symbols = 'fancy'
set t_Co=256
let g:airline_theme='badwolf'
let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮀'

"""""""""""""""""""""""""
" Vim Misc
"""""""""""""""""""""""""
" 現在のディレクトリ直下の .vimsessions/ を取得
let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" 存在すれば
if isdirectory(s:local_session_directory)
  " session保存ディレクトリをそのディレクトリの設定
  let g:session_directory = s:local_session_directory
  " vimを辞める時に自動保存
  let g:session_autosave = 'yes'
  " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
  let g:session_autoload = 'yes'
  " 1分間に1回自動保存
  let g:session_autosave_periodic = 1
else
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
endif
unlet s:local_session_directory

"""""""""""""""""""""""""
" Browsereload
"""""""""""""""""""""""""
let g:returnApp = "iTerm"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
"nmap <Space>ba :AllBrowserReloadStart<CR>
"nmap <Space>bA :AllBrowserReloadStop<CR>

"""""""""""""""""""""""""
" Rails Setting
"""""""""""""""""""""""""
let g:rspec_command = "Dispatch rspec {spec}"

"""""""""""""""""""""""""
" HTML5
"""""""""""""""""""""""""
syn keyword htmlTagName contained article aside audio bb canvas command
syn keyword htmlTagName contained datalist details dialog embed figure
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time
syn keyword htmlTagName contained source figcaption
syn keyword htmlArg contained autofocus autocomplete placeholder min max
syn keyword htmlArg contained contenteditable contextmenu draggable hidden
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget
syn keyword htmlArg contained formaction formenctype formmethod
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"


"""""""""""""""""""""""""
" TypeScript
"""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

"""""""""""""""""""""""""
" Markdown
"""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1

"""""""""""""""""""""""""
" SASS
"""""""""""""""""""""""""
" let g:sass_compile_auto = 1
" let g:sass_compile_cdloop = 5
" let g:sass_compile_cssdir = ['css', 'stylesheet']
" let g:sass_compile_file = ['scss', 'sass']
" let g:sass_started_dirs = []
"
" autocmd FileType less,sass  setlocal sw=2 sts=2 ts=2 et
" " au! BufWritePost * SassCompile

"""""""""""""""""""""""""
" Node JS
"""""""""""""""""""""""""
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_check_on_wq = 0 " wqではチェックしない
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['javascript'],
      \ 'passive_filetypes': []
      \ }
