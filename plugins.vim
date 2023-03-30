" Install vim-plug if we don't already have it
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        execute '!curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

if has('nvim')
    call plug#begin(stdpath('data') . "/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

Plug 'christoomey/vim-tmux-navigator'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'rust-lang/rust.vim'
Plug 'github/copilot.vim'

Plug 'mattn/webapi-vim'
Plug 'airblade/vim-gitgutter'

call plug#end()
