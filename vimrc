" vim:fdm=marker

" Basic settings {{{
set shell=/bin/bash
runtime macros/matchit.vim

syntax on
set background=dark

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

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
set noswapfile
set history=500
set showcmd
set incsearch
set hlsearch
set laststatus=2
set autowrite

set backupdir=~/.vim/backup/

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

set wildmode=list:longest,list:full

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

au FileType qf call AdjustWindowHeight(3, 7)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
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

" elm-vim keybindings
let g:elm_setup_keybindings = 0
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
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_loc_list_height = 6
let g:elm_syntastic_show_warnings = 1
" }}}

" vim <3 tmux {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

let g:tmux_navigator_save_on_switch = 1
" }}}

" fzf {{{
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

" LSP {{{
set hidden
let completeopt = "menuone"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['/usr/bin/pyls'],
    \ }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
noremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
            \ 'auto_complete_delay': 5,
            \ 'min_pattern_length': 1,
            \ })
" }}}
