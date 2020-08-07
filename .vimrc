"Use Vim settings, rather then Vi settings (much better!).
""This must be first, because it changes other options as a side effect.
set nocompatible

filetype off                  " required

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle/')

set viminfo='20,<10000,s10000

" Fuzzy file finder
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Ripgrep stuff for :Find command
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" php
"Plug 'StanAngeloff/php.vim'
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'joonty/vdebug'

" js
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1 "enable jsdoc highlighting

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " enable jsx syntax highlighting for non .jsx files

Plug 'jxnblk/vim-mdx-js'

Plug 'moll/vim-node'

" YouCompleteMe
Plug 'ycm-core/YouCompleteMe'
let g:ycm_filepath_blacklist = {} "whitelist all filetypes for filepath completion

" scss
Plug 'brigade/scss-lint'
Plug 'cakebaker/scss-syntax.vim'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

"editorconfig
Plug 'editorconfig/editorconfig-vim'

"fancy selection
"Plug 'terryma/vim-expand-region'

"code completion
"Plug 'marijnh/tern_for_vim'

" git magic
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost *log* cwindow

" show git diffs in gutter
Plug 'airblade/vim-gitgutter'

" statusline magic
Plug 'bling/vim-airline'

" cool icons for statusline & beyond
Plug 'ryanoasis/vim-devicons'

" file navigation
Plug 'scrooloose/nerdtree'

" commenting
Plug 'scrooloose/nerdcommenter'

autocmd BufEnter *.mdx :setlocal filetype=javascript

" ALE linting
Plug 'dense-analysis/ale'
let g:ale_sign_error = '⛔'
let g:ale_sign_warning = '⚠️'
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '⚠'
autocmd VimEnter * highlight ALEErrorSign ctermbg=NONE ctermfg=red
autocmd VimEnter * highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_linters['mdx'] = ['mdxlint']
let g:ale_linters['css'] = ['stylelint']
let g:ale_linters['scss'] = ['stylelint']

let g:ale_fixers = {}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['css'] = ['stylelint', 'prettier']
let g:ale_fixers['scss'] = ['stylelint', 'prettier']
let g:ale_fixers['javascript'] = ['eslint', 'prettier']
let g:ale_fixers['javascript.jsx'] = ['prettier']

" don't run any linters other than what's explicitly defined above
" let g:ale_linters_explicit = 1

let g:airline#extensions#ale#enabled = 1


" use local .prettierrc
let g:ale_javascript_prettier_use_local_config = 1

" better yanking
Plug 'vim-scripts/YankRing.vim'
" Plug 'maxbrunsfeld/vim-yankstack'

" auto paste mode
Plug 'ConradIrwin/vim-bracketed-paste'

" color theme
Plug 'altercation/vim-colors-solarized'
" Plug 'mhartington/oceanic-next'

" All of your Plugins must be added before the following line
call plug#end()              " required
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

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

if has('mouse_sgr')
    set ttymouse=sgr
endif

"turn on syntax highlighting
syntax enable

"tell the term has 256 colors
set t_Co=256
set background=dark
colorscheme solarized "OceanicNext
let g:oceanic_next_terminal_italic = 1  " enable italics, disabled by default
let g:oceanic_next_terminal_bold = 1    " enable bold, disabled by default

"hide buffers when not displayed
set hidden

" Make tabs 2 spaces wide "
set tabstop=2
set shiftwidth=2
set numberwidth=5
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
set shortmess=a "disable Press ENTER or type command to continue
set cmdheight=2

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

"    set colorcolumn=+1 "mark the ideal max text width
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

nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

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
"autocmd BufReadPost fugitive://* set bufhidden=delete
"autocmd BufReadPost fugitive://*
"  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
"  \   nnoremap <buffer> .. :edit %:h<CR> |
"  \ endif

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NerdTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Fix the difficult-to-read default setting for diff text highlighting.  The
" bang (!) is required since we are overwriting the DiffText setting.
highlight! link DiffText ErrorMsg

set path=.,src
set suffixesadd=.js,.jsx
