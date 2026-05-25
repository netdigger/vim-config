"Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
" gocode is deprecated, replaced by gopls (Go LSP)
" Plug 'nsf/gocode', {'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'}
Plug 'netdigger/vim-octave'
" Pinned: commits after this bump min Vim to 9.1.0016 and Python to 3.12.
" This commit is the last that supports Ubuntu 22.04's Vim 8.2 + Python 3.10.
Plug 'ycm-core/YouCompleteMe', { 'commit': 'b6e8c64d96b02d60b3751d6a51af7dc958054f8f' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' "git
Plug 'mhinz/vim-signify' "git
Plug 'ludovicchabant/vim-gutentags' "ctags
Plug 'dense-analysis/ale'
Plug 'Shougo/echodoc.vim'
Plug 'Yggdroot/LeaderF', {'do':':LeaderfInstallCExtension'}
Plug 'skywind3000/asyncrun.vim'
Plug 'justinmk/vim-dirvish'
Plug 'chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {'do': 'yarn install'}
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }


" Initialize plugin system
call plug#end()

