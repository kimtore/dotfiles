"""""""""""""""""
""" Kim's Vim """
"""""""""""""""""

syntax on
filetype plugin indent on
set ttymouse=xterm
set visualbell
set mouse=a
set bs=2
set ruler
set background=dark
set nocindent
set smartindent
set showmode
set modeline
set nu
set nofoldenable

" GUI options
if has("gui_running")
    set guifont=Inconsolata\ Medium\ 10
end

" Solarized color scheme
let g:solarized_termtrans = 1
colorscheme solarized

" Solarized tweaks
hi! LineNr ctermbg=none

" pathogen
execute pathogen#incubate()
" In certain Vim versions, and with a global config that sets :syntax on
" before ~/.vimrc is loaded, #infect breaks filetype detection.
" https://github.com/tpope/vim-pathogen/issues/38
"execute pathogen#infect()

" proper searching
set ignorecase
set smartcase
set nohlsearch
set noincsearch
nnoremap / /\v
vnoremap / /\v

" write backup files to single directory
set directory=~/.vimtemp
set backupdir=~/.vimtemp

" never switch on cindent
autocmd BufRead * set nocindent

" python indenting
autocmd BufRead *.py set ts=4 sw=4 sts=4 sta et smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" don't move comments to start of line
inoremap # X<c-h>#

" trim whitespace from saved files
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" remap leader key
let mapleader = ','

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

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

" vim-go shouldn't steal our C-T mapping
let g:go_def_mapping_enabled = 0

" run GoImports when saving .go files
let g:go_fmt_command="goimports"

" quick-jump to definition
map <Leader>d :YcmCompleter GoToDefinition<CR>

" NERD tree
map <C-D> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" don't use Ex mode
map Q <Nop>

" switch between header and cpp file
map <C-h> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" any local modifications
if filereadable($HOME."/.vim/local.vim")
    source $HOME/.vim/local.vim"
endif
