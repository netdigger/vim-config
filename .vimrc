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
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'vim-scripts/winmanager'
Plugin 'vim-scripts/minibufexplorerpp'
"Plugin 'vim-scripts/SuperTab'

" Other common plugin
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'

" go plugins
Plugin 'fatih/vim-go'
"gocode install by next command:
"go get -u github.com/nsf/gocode
Plugin 'nsf/gocode', {'rtp': 'vim/'}

" C++ plugins
Plugin 'vim-scripts/OmniCppComplete'

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
"
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
" Auto completed
imap <F4> <C-x><C-o>
"minibufexplorer
let g:miniBufExplMapWindowNavVim = 1 "按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1 "按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapCTabSwitchBufs = 1 "启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
let g:miniBufExplMapCTabSwitchWindows = 1 "启用以下两个功能：Ctrl+tab移到下一个窗口；Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
let g:miniBufExplModSelTarget = 1    "  不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer

"WinManager setting
"let g:winManagerWindowLayout='FileExplorer|TagBar' " 设置我们要管理的插件
"let g:persistentBehaviour=0 " 如果所有编辑文件都关闭了，退出vim
"let g:winManagerWidth=35
"nmap wm :WMToggle<cr>

"Taglist
"let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
"let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
"let Tlist_Show_One_File=1 "让taglist可以同时展示多个文件的函数列表
"let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
"let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"let Tlist_Process_File_Always=1 "实时更新tags 是否一直处理tags.1:处理;0:不处理
"let Tlist_Inc_Winwidth=0

"NERDTree
nmap <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=35

"Tagbar
let g:tagbar_width = 35 "设置宽度
nmap <F3> :TagbarToggle<CR>


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
"set cindent          " Using the indent format of C/C++ 
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     " set the style of C/C++ indent format.

"
"Python
autocmd FileType python setlocal et sta sw=4 sts=4

"Go
autocmd FileType go map <F7>:shell go build <CR><CR><CR> :copen<CR><CR>
