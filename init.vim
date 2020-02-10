" Plugins {{{1
if filereadable(expand("~/.config/nvim/plugins.vim"))
    source ~/.config/nvim/plugins.vim
endif

" Appearance {{{1
set number
set relativenumber
set numberwidth=3

" Deoplete {{{1
let g:deoplete#enable_at_startup=1
call deoplete#custom#option({
            \ 'auto_complete_delay': 10,
            \ })

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

" Completion navigation with tab
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" LanguageClient-neovim {{{1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['$HOME/.local/bin/pyls'],
    \ 'lua': ['lua-lsp'],
    \ }

nnoremap <silent> H :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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
