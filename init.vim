" Plugins {{{1
if filereadable(expand("~/.config/nvim/plugins.vim"))
    source ~/.config/nvim/plugins.vim
endif

" Appearance {{{1
set number
set relativenumber
set numberwidth=3

if len(globpath(&rtp, "colors/solarized.vim")) != 0
    syntax enable
    set background=dark
    colorscheme solarized
endif

" Keybindings {{{1
let mapleader=","

" Reload vnim config
noremap <F5> :source ~/.config/nvim/init.vim<CR>

" Copy to clipboard
noremap <leader>y "+y

" NERDTree
noremap <F8> :NERDTreeToggle<CR>
noremap <F9> :NERDTreeFind<CR>

" fzf
noremap <leader>b :Buffer<CR>
noremap <leader>h :History<CR>
noremap <leader>r :Rg<CR>
noremap <leader>f :exe ':Rg ' . expand('<cword>')<CR>

" Save/Close
nnoremap <leader>q :q<CR>
nnoremap <leader>w :update<CR>

" Wrapped line navigation
nnoremap j gj
nnoremap k gk

" Window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Fold close
nnoremap <leader>cf :foldclose<CR>

" coc.nvim {{{1
set shortmess+=c
set signcolumn=yes
set statusline^=%{coc#status()}
hi Pmenu ctermbg=0
hi Pmenu ctermfg=12
hi CocFloating ctermbg=0
nnoremap <nowait><expr> <C-Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-Down>"
nnoremap <nowait><expr> <C-Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-Up>"
inoremap <nowait><expr> <C-Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-Down>"
inoremap <nowait><expr> <C-Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-Up>"

" Completion navigation with tab
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `gnd` and `gpd` to navigate diagnostics
nmap <silent> gnd <Plug>(coc-diagnostic-next)
nmap <silent> gpd <Plug>(coc-diagnostic-prev)
nmap <silent> gne <Plug>(coc-diagnostic-next-error)
nmap <silent> gpe <Plug>(coc-diagnostic-prev-error)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <silent><F2> <Plug>(coc-rename)

" Applying codeAction to the selected region.
nmap <leader>a <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>x <Plug>(coc-fix-current)

" Go {{{1
au FileType go set noexpandtab

" Python {{{1
let g:python3_host_prog = '/home/pkrones/.local/share/virtualenvs/dotfiles-*/bin/python'

" NERDTree {{{1
let g:NERDTreeWinSize=31

" rust.vim {{{1
let g:rustfmt_autosave_if_config_present = 1
let g:rustc_clip_command = 'xclip -selection clipboard'
let g:rustfmt_command = 'rustup run nightly rustfmt'

" Spellcheck {{{1
set spelllang=en_us,de_de

" Statusline {{{1
function! GitBranch()
    let l:branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branch) > 0 ? '  ' . l:branch . ' ' : ''
endfunction

hi StatusLineBranch cterm=bold ctermfg=Black ctermbg=LightGrey
hi StatusLineFile ctermfg=LightGrey ctermbg=Blue
hi StatusLineRight ctermfg=15 ctermbg=DarkGrey
hi StatusLineEmpty ctermfg=0 ctermbg=0

set statusline=
set statusline+=%#StatusLine#
set statusline+=%{GitBranch()}
set statusline+=%#StatusLineFile#
set statusline+=\ %f%m%r
set statusline+=\ %#StatusLineEmpty#
set statusline+=%=
set statusline+=%#StatusLineRight#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\[%{&fileformat}\]
set statusline+=\ %l/%L\ (%p%%):%c\ |

" Usability {{{1
set splitbelow
set splitright

set foldmethod=marker

let loaded_matchit = 1

set hidden

set ignorecase
set smartcase

set cmdheight=2

set updatetime=300

function! s:RemoveTrailingWhitespaces()
    "Save last cursor position
    let l = line(".")
    let c = col(".")

    %s/\s\+$//ge

    call cursor(l,c)
endfunction

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

augroup vimrcEx
    autocmd!

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
    autocmd FileType changelog setlocal spell

    " Automatically wrap at 80 characters for text files
    autocmd FileType text setlocal textwidth=80
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=80

    " Adjust quickfix window size
    autocmd FileType qf call AdjustWindowHeight(0, 7)

    " Remove trailing whitespace on save
    autocmd BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END

" vim-tmux-navigator {{{1
let g:tmux_navigator_save_on_switch = 1

" Whitespace {{{1
set expandtab
set shiftwidth=4
set tabstop=4
set list
set listchars=tab:»·,trail:·
