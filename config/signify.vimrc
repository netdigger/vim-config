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
