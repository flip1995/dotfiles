" vim:fdm=marker

" Basic settings {{{
set shell=/bin/bash
runtime macros/matchit.vim

set ttyfast
set lazyredraw

let g:ruby_path="~/.rvm/bin/ruby"

let $PATH='/usr/local/bin:' . $PATH

:au FocusLost * :wa "Save on focus lost

" Reduce timeout after <ESC> is recvd. This is only a good idea on fast links.
set ttimeout
set ttimeoutlen=200
set notimeout

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight matches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

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
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
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

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
" }}}

" Keymappings {{{
:let mapleader=','

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easy tab navigation
nnoremap <Leader>p :tabprevious<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>c :tabclose<CR>

" Copy and Paste to clipboard
nmap <C-a> ggVG
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
vnoremap <Leader>t :TCommentBlock<CR>

" Toggle nerdtree with F8
map <F8> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Fold
map <leader>f :foldclose<CR>

" Count occurences of word under cursor
map ,* *<C-O>:%s///gn<CR>

" Reload .vimrc
map <F5> :source $MYVIMRC<CR>
" }}}

" vim <3 tmux {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

let g:tmux_navigator_save_on_switch = 1
" }}}

"For nicer looking {{{
" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505

" Numbers
set number
set numberwidth=5

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

" Searching {{{
:set smartcase
:set ignorecase
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='solarized'
set t_Co=256
" }}}

" Color scheme {{{
:colorscheme oceandeep
" }}}
