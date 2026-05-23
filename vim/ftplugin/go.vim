" Build (F7), run (F5), test (F11)
nnoremap <buffer> <F5> :AsyncRun go run %<CR>
nnoremap <buffer> <F7> :AsyncRun go build ./...<CR>
nnoremap <buffer> <F11> :AsyncRun go test ./...<CR>:copen<CR>
inoremap <buffer> <F5> <ESC>:AsyncRun go run %<CR>
inoremap <buffer> <F7> <ESC>:AsyncRun go build ./...<CR>
inoremap <buffer> <F11> <ESC>:AsyncRun go test ./...<CR>:copen<CR>
