if &compatible
  set nocompatible
endif

"*****************************************************************************
"" Plugins
"*****************************************************************************
call plug#begin('~/.vim/plugged')

"" Themes
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'liuchengxu/space-vim-dark'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'KeitaNakamura/neodark.vim'

"" Visual tab {bottom}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Tree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

"" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'

"" Smart comments
Plug 'tpope/vim-commentary'

"" Git
Plug 'tpope/vim-fugitive'

"" Shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

"" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

"" Javascript
Plug 'moll/vim-node'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'heavenshell/vim-jsdoc', { 'on': '<Plug>(jsdoc)' }
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

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

"" TypeScript
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

"" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'

"" Markdown
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

"" Log
Plug 'mtdl9/vim-log-highlighting'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" A code-completion engine for Vim
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --js-completer --java-completer' }

"" Asynchronous Lint Engine
Plug 'w0rp/ale'

"" A set of mappings for HTML, XML, PHP, ASP, eRuby, JSP, and more
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'

"" Simplifies the transition between multiline and single-line code (gS, gJ)
Plug 'AndrewRadev/splitjoin.vim'

"" Type vv inside pairs objects such as () to select content
Plug 'gorkunov/smartpairs.vim'

"" Type * to search the word under the cursor or selected text
Plug 'thinca/vim-visualstar'

"" This plugin causes all trailing whitespace to be highlighted in red.
Plug 'bronson/vim-trailing-whitespace'

"" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

"" A Vim plugin that manages your tag files
Plug 'ludovicchabant/vim-gutentags'

"" Tagbar displays the tags of the current file in a sidebar,
Plug 'majutsushi/tagbar'

"" Vim and tmux, sittin' in a tree
Plug 'christoomey/vim-tmux-runner'
Plug 'christoomey/vim-tmux-navigator'

"" Helpers for UNIX (:Delete, :Move, :Chmod,...)
Plug 'tpope/vim-eunuch'

"" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

"" EditorConfig plugin for Vim
Plug 'editorconfig/editorconfig-vim'

"" Interactive command execution in Vim.
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"" Improved integration between Vim and its environment
Plug 'Shougo/vimshell.vim'

"" Asks to create directories in Vim when needed
Plug 'jordwalke/VimAutoMakeDirectory'

"" Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

"" Helpers
Plug 'phongnh/vim-search-helpers'
Plug 'kristijanhusak/vim-carbon-now-sh'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************

filetype plugin indent on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Alias unnamed register to the * register
set clipboard=unnamed

"" Alias unnamed register to the + register, which is the X Window clipboard
" set clipboard=unnamedplus

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

"" Map leader to space
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Completion Options
set completeopt-=preview

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

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

colorscheme iceberg
set background=dark

set mouse=a
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has('mouse_sgr')
  set ttymouse=sgr
endif

if has('gui_running')
  if has('gui_mac') || has('gui_macvim')
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1


  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif

endif

if &term =~ '256color'
  set t_ut=
endif

"" True Color
"Use 24-bit (true-color) mode in Vim/Neovim (http://sunaku.github.io/tmux-24bit-color.html#usage)
"For Neovim 0.1.3 and 0.1.4 (https://github.com/neovim/neovim/pull/2198)
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 (https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162)
"Based on Vim patch 7.4.1770 (`guicolors` option) (https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd)
"(https://github.com/neovim/neovim/wiki/Following-HEAD#20160511)
if (has('termguicolors'))
  set termguicolors
endif

"" Highlight line
" Disable to speed up highlighting
" set cursorline
hi cursorline cterm=none term=none
highlight CursorLine ctermbg=235

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=0

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

set autoread
set autowrite

"*****************************************************************************
"" Plugins Configuration
"*****************************************************************************
"" NERDTree configuration
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'iceberg'
let g:airline#extensions#tabline#enabled = 1

"" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = '$ '

"" UltiSnips
" YouCompleteMe and UltiSnips compatibility
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-z>'
" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']
" Additional UltiSnips => add ultisnips folder in .vim
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips']

"" Ack.vim
" Use Ag with Ack.vim (requires Ag [brew install the_silver_searcher])
let g:ackprg = 'ag --vimgrep'

"" ALE
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = { 'javascript': ['eslint'] }

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

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>buildGoFiles()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
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
"" Key Maps
"*****************************************************************************
nnoremap <Leader>\| :NERDTreeTabsToggle<CR>
nnoremap <Leader>\ :NERDTreeTabsFind<CR>
nnoremap <Leader>p :PrettierAsync<CR>
nnoremap <Leader>f :ALEFix<CR>
nnoremap <C-p> :Files<CR>
nnoremap <silent> <ESC> :noh<CR>
nnoremap <ESC>^[ <ESC>^[

" Search
nnoremap <Leader>S :Ack! <C-r>=expand("<cword>")<CR><CR>
xnoremap <Leader>S <Esc>:Ack! "<C-r>=escape(GetSelectedText(), '"%#*$(){}')<CR>"<CR>

" Replace
nnoremap <Leader>R :%s/<C-r>=GetWordForSubstitute()<CR>/gcI<Left><Left><Left><Left>
xnoremap <Leader>R <Esc>:%s/<C-r>=GetSelectedTextForSubstitute()<CR>//gcI<Left><Left><Left><Left>

" Jump to next error with Ctrl-n and previous error with Ctrl-m
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
" Close the quickfix window with <leader>a
nnoremap <leader>a :cclose<CR>
