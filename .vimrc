"User Manual
"Install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" wget https://github.com/netdigger/vim-config/raw/master/.vimrc ~/
" Start vim
" Run :BundleInstall
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" vim standard plugin
Plugin 'vim-scripts/minibufexplorerpp'

" Other common plugin
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'

" go plugins
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

" Octave plugins
Plugin 'netdigger/vim-octave'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" Powerline
"Plugin 'powerline/powerline'

"Air line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Git
Plugin 'tpope/vim-fugitive'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Common setting
syntax on            " On the syntax color
colorscheme ron      " elflord ron peachpuff default 
set autowrite        " AutoSave the modified file.
set autoindent       " It is used 'set noautoindent' to cancel the auto indent.
set number           " Enable line number
set tabstop=4        " Tab stop
set shiftwidth=4
set noexpandtab
set softtabstop=4    " soft tab stop 
set showmatch        " 
set linebreak        " 
set laststatus=2

highlight PMenu ctermfg=white  ctermbg=darkgray
highlight PMenuSel ctermfg=white ctermbg=darkgreen

"minibufexplorer
"按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavVim = 1 
"按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1 
"启用以下两个功能：
"Ctrl+tab移到下一个buffer并在当前窗口打开；
"Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；
"Ubuntu好像不支持
let g:miniBufExplMapCTabSwitchBufs = 1  
"启用以下两个功能：Ctrl+tab移到下一个窗口；
"Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
let g:miniBufExplMapCTabSwitchWindows = 1 
"不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
let g:miniBufExplModSelTarget = 1    

"NERDTree
nmap <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=35

"Tagbar
let g:tagbar_width = 35 "设置宽度
nmap <F3> :TagbarToggle<CR>

"YouCompleteMe
set completeopt=menu,menuone
" Close the preview window
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_python_binary_path = 'python'

"Powerline
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"Air line
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline_solarized_bg='dark'
let g:airline#extensions#branch#enabled = 1

" QuickFix setting --
" 按下F6，执行make clean
map <F6> :make clean<CR><CR><CR>
" 按下F7，执行make编译程序，并打开quickfix窗口，显示编译信息
map <F7> :make<CR><CR><CR> :copen<CR><CR>
" 按下F8，光标移到上一个错误所在的行
map <F8> :cp<CR>
" 按下F9，光标移到下一个错误所在的行
map <F9> :cn<CR>
" 按下F12，执行make test，并打开quickfix窗口，显示编译信息
map <F12> :make test<CR><CR><CR> :copen<CR><CR>

" 以上的映射是使上面的快捷键在插入模式下也能用
imap <F6> <ESC>:make clean<CR><CR><CR>
imap <F7> <ESC>:make<CR><CR><CR> :copen<CR><CR>
imap <F8> <ESC>:cp<CR>
imap <F9> <ESC>:cn<CR>
imap <F12> <ESC>:make test<CR><CR><CR> :copen<CR><CR>

"C++
set cindent          " Using the indent format of C/C++ 
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     " set the style of C/C++ indent format.

"Python
autocmd FileType python setlocal et sta sw=4 sts=4

"Go
autocmd FileType go map <F7>:shell go build <CR><CR><CR> :copen<CR><CR>
let g:go_fmt_command = "goimports"   "replace gofmt by goimports

"Octave and metlab
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END
