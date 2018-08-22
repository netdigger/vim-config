"User Manual
"set nocompatible              " be iMproved, required
"filetype off                  " required

"Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" vim standard plugin
Plug 'vim-scripts/minibufexplorerpp'

" Other common plugin
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'

" go plugins
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'nsf/gocode', {'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'}

" Octave plugins
Plug 'netdigger/vim-octave'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe'

"Air line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Git
Plug 'tpope/vim-fugitive'

"tags
Plug 'ludovicchabant/vim-gutentags'

"ALE
Plug 'w0rp/ale'

"Echodoc
Plug 'Shougo/echodoc.vim'

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"Common setting
syntax on            " On the syntax color
colorscheme ron      " elflord ron peachpuff default 
set autowrite        " AutoSave the modified file.
set autoindent       " It is used 'set noautoindent' to cancel the auto indent.
set number           " Enable line number
set tabstop=4        " Tab stop
set shiftwidth=4
set noshowmode		 " Close Show mode
set noexpandtab
set softtabstop=4    " soft tab stop 
set showmatch        " 
set linebreak        " 
set laststatus=2

" Highlight the content over 80 characters.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

highlight PMenu ctermfg=white  ctermbg=darkgray
highlight PMenuSel ctermfg=white ctermbg=darkgreen

set tags=./.tags;,.tags

noremap <c-d> :sh<cr>

" Gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"ALE
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

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
