" kbash vim
syntax on
set ttymouse=xterm
set visualbell
set mouse=a
set bs=2
set ruler
set background=dark
set smartindent
set showmode
set nohlsearch
set noincsearch
set nu

" no word wrap
set formatoptions=l
set lbr

" nice dvorak'y window switching
map <C-T> <C-W>j<C-W>_
map <C-C> <C-W>k<C-W>_
map <C-N> <Esc>:new<CR><C-W>_
map <C-J> <Esc>:split<CR><C-W>_
map <C-K> <Esc>:quit<CR><C-W>_
set wmh=0 

" switch between header and cpp file
map <C-h> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
