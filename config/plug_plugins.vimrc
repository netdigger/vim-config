"Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'nsf/gocode', {'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'}
Plug 'netdigger/vim-octave'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' "git
Plug 'mhinz/vim-signify' "git
Plug 'ludovicchabant/vim-gutentags' "ctags
Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'
Plug 'Yggdroot/LeaderF', {'do':':LeaderfInstallCExtension'}
Plug 'skywind3000/asyncrun.vim'
Plug 'justinmk/vim-dirvish'
Plug 'chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {'do': 'yarn install'}


" Initialize plugin system
call plug#end()

