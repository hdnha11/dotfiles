if &compatible
  set nocompatible
endif

"*****************************************************************************
"" Plugins
"*****************************************************************************
call plug#begin('~/.vim/plugged')

"" Themes
Plug 'KeitaNakamura/neodark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'nanotech/jellybeans.vim'
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'

"" Visual tab {bottom}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Tree
Plug 'scrooloose/nerdtree'

"" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Grep
Plug 'mhinz/vim-grepper'

"" Smart comments
Plug 'tpope/vim-commentary'

"" Git
Plug 'tpope/vim-fugitive'

"" Shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

"" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

"" Ruby
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'

"" HTML
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'mattn/emmet-vim'

"" CSS
Plug 'hail2u/vim-css3-syntax'
Plug 'griffinqiu/vim-coloresque'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Markdown
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

"" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" A set of mappings for HTML, XML, PHP, ASP, eRuby, JSP, and more
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'

"" Simplifies the transition between multiline and single-line code (gS, gJ)
Plug 'AndrewRadev/splitjoin.vim'

"" Type vv inside pairs objects such as () to select content
Plug 'gorkunov/smartpairs.vim'

"" This plugin causes all trailing whitespace to be highlighted in red.
Plug 'bronson/vim-trailing-whitespace'

"" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

"" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

"" EditorConfig plugin for Vim
Plug 'editorconfig/editorconfig-vim'

"" Asks to create directories in Vim when needed
Plug 'jordwalke/VimAutoMakeDirectory'

"" Start a * or # search from a visual block
Plug 'nelstrom/vim-visual-star-search'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************

filetype plugin indent on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

"" Map leader to space
let mapleader = ' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Completion Options
set completeopt+=preview
set shortmess+=c

"" Command-line completion operates in an enhanced
set wildmenu
set wildmode=full

"" Folding
set foldmethod=indent
set nofoldenable

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

set autoread
set autowrite

"" Session management
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

"" Persistent undo
if has('persistent_undo')
  set undofile
  " Run mkdir ~/.vim/undo if undo folder is not exists
  set undodir=~/.vim/undo
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set ruler
set number

let no_buffers_menu = 1

colorscheme nord
set background=dark

set mouse=a
set mousemodel=popup

if has('mouse_sgr')
  set ttymouse=sgr
endif

set term=$TERM

"" True Color
if (has('termguicolors'))
  set termguicolors
endif

"" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

"" Always show signcolumns
set signcolumn=yes

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold=
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists('*fugitive#statusline')
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

function! s:setupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

function! s:showDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

"*****************************************************************************
"" Plugins Configuration
"*****************************************************************************
"" NERDTree configuration
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = '!'

"" Grepper
let g:grepper = {
\ 'tools': ['rg', 'ag', 'git', 'grep']
\}

"" Coc
let g:coc_global_extensions = [
\ 'coc-clangd',
\ 'coc-css',
\ 'coc-eslint',
\ 'coc-flutter',
\ 'coc-fsharp',
\ 'coc-go',
\ 'coc-html',
\ 'coc-java',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-python',
\ 'coc-rls',
\ 'coc-svelte',
\ 'coc-tsserver',
\]

command! -nargs=0 Format :call CocAction('format')

"" vim-go
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
let g:go_list_type = 'quickfix'
let g:go_addtags_transform = 'camelcase'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <Leader>b :<C-u>call <SID>buildGoFiles()<CR>
augroup END

" buildGoFiles is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:buildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"*****************************************************************************
"" Command Aliases
"*****************************************************************************
call s:setupCommandAlias('grep', 'GrepperRg')
call s:setupCommandAlias('search', 'CocSearch')

"*****************************************************************************
"" Key Maps
"*****************************************************************************
nnoremap <C-p> :Files<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Format
xmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)
nnoremap <Leader>F :Format<CR>

" Code actions
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a v<Plug>(coc-codeaction-selected)
nmap <Leader>A <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line
nmap <Leader>qf <Plug>(coc-fix-current)

" Remap for rename current word
nmap <Leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>showDocumentation()<CR>

" Mappings using CocList
nnoremap <silent> <Leader>cd :<C-u>CocList diagnostics<CR>
nnoremap <silent> <Leader>ce :<C-u>CocList extensions<CR>
nnoremap <silent> <Leader>cc :<C-u>CocList commands<CR>
nnoremap <silent> <Leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <Leader>cs :<C-u>CocList -I symbols<CR>

" Close the quickfix window with <Leader>a
nnoremap <Leader>Q :cclose<CR>
