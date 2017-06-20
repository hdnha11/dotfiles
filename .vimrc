"*****************************************************************************
"" Plugins
"*****************************************************************************
call plug#begin('~/.vim/plugged')

"" Themes
Plug 'rakr/vim-one'

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
Plug 'tpope/vim-git'

"" Shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

"" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

"" Javascript
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'leshill/vim-json'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'briancollins/vim-jst'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'burnettk/vim-angular'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'heavenshell/vim-jsdoc', { 'on': '<Plug>(jsdoc)' }

"" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'

"" HTML
Plug 'othree/html5.vim'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'tpope/vim-haml'
Plug 'digitaltoad/vim-jade'

"" CSS
Plug 'wavded/vim-stylus'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'gorodinskiy/vim-coloresque'

"" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

"" Go
Plug 'fatih/vim-go'

"" Elm
Plug 'ElmCast/elm-vim'

"" Markdown
Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

"" Elixir
Plug 'elixir-lang/vim-elixir'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" A code-completion engine for Vim
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

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

"" Tagbar displays the tags of the current file in a sidebar,
Plug 'majutsushi/tagbar'

"" Vim and tmux, sittin' in a tree
Plug 'christoomey/vim-tmux-runner'
Plug 'christoomey/vim-tmux-navigator'

"" Provides a :Rbenv command that wraps !rbenv with tab complete
Plug 'tpope/vim-rbenv'

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

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************

if &compatible
  set nocompatible
endif

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

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

" session management
let g:session_directory="~/.vim/session"
let g:session_autoload="no"
let g:session_autosave="no"
let g:session_command_aliases=1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set ruler
set number

let no_buffers_menu=1

colorscheme one
set background=dark

set mouse=a
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded=1


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

" Highlight line
set cursorline
hi cursorline cterm=none term=none
highlight CursorLine ctermbg=235
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
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

"*****************************************************************************
"" Plugins Configuration
"*****************************************************************************
"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent='<RightMouse>'
let g:NERDTreeWinSize=30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled=1

"" One-Dark
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"" vimshell.vim
let g:vimshell_user_prompt='fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt='$ '

"" UltiSnips
" YouCompleteMe and UltiSnips compatibility
let g:UltiSnipsExpandTrigger='<c-l>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore=['autocomplete']
" Additional UltiSnips => add ultisnips folder in .vim
let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories=['ultisnips']

"" Ack.vim
" Use Ag with Ack.vim (requires Ag [brew install the_silver_searcher])
let g:ackprg = 'ag --vimgrep'

"*****************************************************************************
"" Key Maps
"*****************************************************************************
nnoremap <C-e> :NERDTreeTabsToggle<CR>
nnoremap <Leader>\ :NERDTreeTabsFind<CR>
nnoremap <C-p> :Files<CR>
nnoremap <silent> <ESC> :noh<CR>
