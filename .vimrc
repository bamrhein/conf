" VISUAL
set nocompatible
syntax on
colorscheme desert
 
" ENVIRONMENT
set incsearch "find as a you type search
set ignorecase smartcase
set mouse=a "enables mouse
set hidden "allows editing of multiple unsaved buffers
set autochdir
 
" FORMATTING
set autoindent "indent at the same level of the previous line
set smartindent "VIM can indent FOR you!
set cindent "VIM knows indenting C-style!
set smarttab "detects how much to auto-tab
filetype on
filetype plugin on
filetype indent on
set expandtab "use spaces instead of tabs
set tabstop=8 "number of spaces in a tab
set shiftwidth=4 "number of spaces to use for each (auto)indent
set softtabstop=4 "number of spaces that a <Tab> in the file counts for
 
" SESSIONS
set sessionoptions+=resize
map <c-q> :mksession! ~/.vim/.session <cr>
map <c-s> :source~/.vim/.session <cr>
 
" Personal Keybinds
map <c-c> :s/^/\/\/<cr>
map <F5> :!javac %<cr>
 
 
" GUI settings
if has("gui_running")
    colorscheme ir_black
    set guifont=Inconsolata\ 11 "this is the default font in gvim. Adjust size as
                                "needed (8 or 9 is good)
 
    set guioptions-=m "removes menu
    set guioptions-=T "removes toolbar
    set guioptions-=l "removes left scrollbar
    set guioptions-=r "removes right scrollbar
    set guioptions-=b "removes bottom scrollbar
    set guioptions-=L "removes left scrollbar when :vsp
    set guioptions-=R "removes right scrollbar when :vsp
endif

" Syntax modes
au BufNewFile,BufRead *.wiki set syntax=wikipedia
