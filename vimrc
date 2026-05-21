"User Manual
"filetype off                  " required
"

let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" Plug plugin list
execute 'source ' . s:config_dir . '/config/plug_plugins.vimrc'

"Common setting
syntax on            " On the syntax color
filetype plugin indent on    " required
colorscheme ron      " elflord ron peachpuff default
set autowrite        " AutoSave the modified file.
set autoindent       " It is used 'set noautoindent' to cancel the auto indent.
set number           " Enable line number
set tabstop=4        " Tab stop
set expandtab
set shiftwidth=4     " Indent width
set softtabstop=4    " Soft tab stop
set noshowmode       " Close Show mode
set showmatch        "
set linebreak        "
set laststatus=2


highlight Pmenu ctermfg=white  ctermbg=darkgray
highlight PmenuSel ctermfg=white ctermbg=darkgreen

let mapleader = " "
set tags=./.tags;,.tags

nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

"Terminal
nnoremap <leader>w :vert ter ++open ++cols=65<CR>
tnoremap <Esc> <C-W>N
tnoremap <C-C> <C-W><C-C>

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change            = '~'
nnoremap <leader>d :SignifyDiff<cr>
nnoremap <leader>c :tabclose<cr>
" highlight lines in Sy and vimdiff etc.)
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=yellow
" highlight signs in Sy
highlight SignifySignAdd    cterm=bold guibg=darkgray  ctermfg=green
highlight SignifySignDelete cterm=bold guibg=darkgray  ctermfg=red
highlight SignifySignChange cterm=bold guibg=darkgray  ctermfg=yellow

" AsyncRun
let g:asyncrun_open = 6
let g:asyncrun_bell = 1

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

" ALE
execute 'source ' . s:config_dir . '/config/ale.vimrc'

" FZF
execute 'source ' . s:config_dir . '/config/fzf.vimrc'

" LeaderF
" noremap <leader>o :LeaderfFile<cr>
nnoremap <leader>m :LeaderfMru<cr>
nnoremap <leader>f :LeaderfFunction!<cr>
nnoremap <leader>b :LeaderfBuffer<cr>
nnoremap <leader>t :LeaderfTag<cr>
nnoremap <leader>l :LeaderfLine<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': ''}
let g:Lf_MruFileExclude = ['*.so', '*.a', '*.bin', '*.out']
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_RootMarkers = ['.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'aAc'
let g:Lf_WindowHeight = 0.40
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

"YouCompleteMe
set completeopt=menu,menuone
" Close the preview window
let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
let g:ycm_python_binary_path = 'python'
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

"Air line
execute 'source ' . s:config_dir . '/config/airline.vimrc'

" EchoDoc
set cmdheight=1
let g:echodoc_enable_at_startup = 1

" QuickFix setting --
" Insert DateTime String
nnoremap <c-t> :put =strftime('%Y-%m-%dT%H:%M:%S%z')<CR>
inoremap <c-t> <ESC>:put =strftime('%Y-%m-%dT%H:%M:%S%z')<CR>

" C++
nnoremap <F8> :cn<CR>
nnoremap <F9> :cp<CR>
nnoremap <F10> :cclose<CR>

inoremap <F8> <ESC>:cn<CR>
inoremap <F9> <ESC>:cp<CR>
inoremap <F10> :cclose<CR>

"C++
set cindent          " Using the indent format of C/C++
" set the style of C/C++ indent format.
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
autocmd FileType c,cpp nnoremap <F6> :make clean<CR>
autocmd FileType c,cpp nnoremap <F7> :AsyncRun make<CR>copen<CR>
autocmd FileType c,cpp nnoremap <F11> :make test<CR> :copen<CR>
autocmd FileType c,cpp inoremap <F6> <ESC>:make clean<CR>
autocmd FileType c,cpp inoremap <F7> <ESC>:AsyncRun make<CR> :copen<CR>
autocmd FileType c,cpp inoremap <F11> <ESC>:make test<CR>:copen<CR>

"Python
autocmd FileType python setlocal et sta sw=4 sts=4

"Go
autocmd FileType go nnoremap <F7>:shell go build <CR><CR><CR> :copen<CR><CR>
let g:go_fmt_command = "goimports"   "replace gofmt by goimports

"Octave and metlab
augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

" Auto-Format
execute 'source ' . s:config_dir . '/config/autoformat.vimrc'
