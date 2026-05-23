" ── Git (vim-fugitive + vim-signify) ──

" vim-signify: gutter signs
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change            = '~'

highlight DiffAdd           cterm=bold ctermbg=none ctermfg=green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=yellow
highlight SignifySignAdd    cterm=bold guibg=darkgray  ctermfg=green
highlight SignifySignDelete cterm=bold guibg=darkgray  ctermfg=red
highlight SignifySignChange cterm=bold guibg=darkgray  ctermfg=yellow

" ── Keybindings ──
" <Space>g  → Git status (Fugitive)
nnoremap <leader>g :Git<CR>

" <Space>gb → Git blame
nnoremap <leader>gb :Git blame<CR>

" <Space>gd → Diff current file (Signify)
nnoremap <leader>gd :SignifyDiff<CR>

" <Space>gc → Git commit
nnoremap <leader>gc :Git commit<CR>

" <Space>gp → Git push
nnoremap <leader>gp :Git push<CR>

" <Space>gl → Git pull
nnoremap <leader>gl :Git pull<CR>

" <Space>gr → Git log (current file)
nnoremap <leader>gr :Git log --oneline %<CR>

" <Space>gR → Git log (all)
nnoremap <leader>gR :Git log --oneline<CR>
