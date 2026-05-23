" LeaderF
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
