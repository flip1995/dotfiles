" vim:fdm=marker

" Basic settings {{{
set shell=/bin/bash
runtime macros/matchit.vim

syntax on
set background=dark

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

filetype plugin indent on

set ttyfast
set lazyredraw

:au FocusLost * :wa "Save on focus lost

" Reduce timeout after <ESC> is recvd. This is only a good idea on fast links.
set ttimeout
set ttimeoutlen=200
set notimeout

" Line numbers
set number
set relativenumber
set numberwidth=3

set backspace=2
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set history=500
set showcmd
set incsearch
set hlsearch
set laststatus=2
set autowrite

set t_Co=256

:set spelllang=en_us,de_de

augroup vimrcEx
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " Enable spellchecking
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.tex setlocal spell
    autocmd FileType gitcommit setlocal spell

    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=80

    " Automatically open quickfix after searching with grep and friends
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

set encoding=utf-8

set cmdheight=2

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" Searching
:set smartcase
:set ignorecase

" Use vimtex, instead of polyglot
let g:polyglot_disabled = ['latex']
" }}}

" Usability {{{
let g:NERDTreeWinSize=31
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Remove trailing whitespace on save
function! s:RemoveTrailingWhitespaces()
    "Save last cursor position
    let l = line(".")
    let c = col(".")

    %s/\s\+$//ge

    call cursor(l,c)
endfunction

au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
" }}}

" Keymappings {{{
:let mapleader=','

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Better navigation in wrapped lines
nnoremap j gj
nnoremap k gk

" Copy and paste to clipboard
nmap <leader>a ggVG
vmap <C-c> "+y
vmap <Insert> d"+gP
nmap <Insert> "+gp

" Leader Mappings
map <Leader>w :update<CR>
map <Leader>q :q<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Gpush<CR>

" Toggle Comment
nnoremap <Leader>t :TComment<CR>
vnoremap <Leader>t :TComment<CR>

" Toggle NERDtree with F8
map <F8> :NERDTreeToggle<CR>
" Current file in NERDtree
map <F9> :NERDTreeFind<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Count occurences of word under cursor
map <Leader>* *<C-O>:%s///gn<CR>

" Reload .vimrc
map <F5> :source $MYVIMRC<CR>
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='solarized'
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_loc_list_height = 5
" }}}

" vim <3 tmux {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

let g:tmux_navigator_save_on_switch = 1
" }}}
