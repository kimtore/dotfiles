"""""""""""""""""
""" Kim's Vim """
"""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Global plugins
Plugin 'preservim/nerdtree'

" locally installed plugins
if filereadable($HOME."/.vim/plugins.vim")
    source $HOME/.vim/plugins.vim"
endif

call vundle#end()            " required

if &term =~ 'xterm\|kitty\|alacritty\|tmux'
    let &t_Ts = "\e[9m"   " Strikethrough
    let &t_Te = "\e[29m"
    let &t_Cs = "\e[4:3m" " Undercurl
    let &t_Ce = "\e[4:0m"
endif

syntax on
filetype plugin indent on
set background=dark
set bs=indent,eol,start
set encoding=utf-8
set expandtab
set modeline
set mouse=a
set nocindent
set nofoldenable
set nu
set ruler
set shiftwidth=4
set showmode
set smartindent
set smarttab
set softtabstop=0
set tabstop=4
set ttyfast
set ttymouse=xterm
set visualbell

" GUI options
if has("gui_running")
    set guifont=Inconsolata:h14
end

" Solarized color scheme
let g:solarized_termtrans = 1
colorscheme solarized

" Solarized tweaks
hi! LineNr ctermbg=none

" proper searching
set ignorecase
set smartcase
set nohlsearch
set noincsearch
nnoremap / /\v
vnoremap / /\v

" disable swap-on-paste
vnoremap p "_dP

" write backup files to single directory
set directory=~/.vimtemp
set backupdir=~/.vimtemp

" never switch on cindent
autocmd BufRead * set nocindent

" python indenting
autocmd BufNewFile,BufRead *.py set ts=4 sw=4 sts=4 sta et smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

" remap leader key
let mapleader = ','

" don't move comments to start of line
inoremap # X<c-h>#

" whitespace trimming
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
map <Leader>w :call TrimWhitespace()<CR>

" automatic whitespace trim on save
"autocmd BufWritePre * :call TrimWhitespace()

" don't intrude into my clipboard please
if has("clipboard")
    set clipboard-=autoselect
endif

" sparkup mapping breaks scroll-down, remap it
let g:sparkupExecuteMapping = '<c-p>'

" map :W to write with create directory
function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command! W call WriteCreatingDirs()

" python tabs
" modeline: /* vim: set ts=4 sw=4 sts=4 sta et: */
" http://www.vex.net/~x/python_and_vim.html

" no word wrap
set formatoptions=l
set lbr

" nice dvorak'y window switching
map <C-T> <C-W>j
map <C-C> <C-W>k
map <C-N> <Esc>:new<CR>
map <C-J> <Esc>:split<CR>
map <C-K> <Esc>:quit<CR>
set wmh=0
set noequalalways
set winheight=99999

" proper tab settings in Go files
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" --- NERD tree
map <C-D> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" don't use Ex mode
map Q <Nop>

" switch between header and cpp file
map <C-h> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" --- any local modifications
if filereadable($HOME."/.vim/local.vim")
    source $HOME/.vim/local.vim"
endif
