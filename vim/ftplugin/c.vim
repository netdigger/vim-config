" C/C++ indent
setlocal cindent
setlocal cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" Build and test (F6=clean, F7=build, F11=test)
nnoremap <buffer> <F6> :make clean<CR>
nnoremap <buffer> <F7> :AsyncRun make<CR>
nnoremap <buffer> <F11> :make test<CR>:copen<CR>
inoremap <buffer> <F6> <ESC>:make clean<CR>
inoremap <buffer> <F7> <ESC>:AsyncRun make<CR>
inoremap <buffer> <F11> <ESC>:make test<CR>:copen<CR>

" Highlight the content over 80 characters.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
