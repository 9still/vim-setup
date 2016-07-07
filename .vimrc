"Use Vim settings, rather then Vi settings (much better!).
""This must be first, because it changes other options as a side effect.
set nocompatible

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

" php
Plugin 'StanAngeloff/php.vim'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'joonty/vdebug'

" js
Plugin 'jelera/vim-javascript-syntax'
Plugin 'moll/vim-node'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

" scss
Plugin 'brigade/scss-lint'
Plugin 'cakebaker/scss-syntax.vim'

"editorconfig
Plugin 'editorconfig/editorconfig-vim'

"fancy selection
Plugin 'terryma/vim-expand-region'

"code completion
Plugin 'marijnh/tern_for_vim'

" git magic
Plugin 'tpope/vim-fugitive'

" show git diffs in gutter
Plugin 'airblade/vim-gitgutter'

" statusline magic
Plugin 'bling/vim-airline'

" file navigation
Plugin 'scrooloose/nerdtree'

" commenting
Plugin 'scrooloose/nerdcommenter'

" better yanking
Plugin 'vim-scripts/YankRing.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

" Make tabs 4 spaces wide "
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set number      "show line numbers
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points
set laststatus=2  "always show statusline

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    "set colorcolumn=+1 "mark the ideal max text width
endif

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Paste Mode!  Dang! <F10>
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc

nnoremap <C-F10> :call Paste_on_off()<CR>
set pastetoggle=<C-F10>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" plugin settings
"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_aggregate_errors = 1

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NerdTree with Ctrl-N
map <C-F11> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"some stuff to get the mouse going in term
set mouse=a

if has('mouse_sgr')
    set ttymouse=sgr
endif

set ttymouse=xterm2
