" ── Terminal ──
" <Space>`  = toggle terminal (show/hide, keeps process alive)
" <Space>w  = vertical terminal
" <Space>W  = horizontal terminal
" <Esc><Esc> = exit Terminal-Insert mode

function! s:TermToggle()
    let l:buf = bufnr('__terminal__')
    if l:buf == -1
        " No terminal yet: create one
        below split | terminal ++close
        file __terminal__
    elseif bufwinnr(l:buf) == -1
        " Terminal exists but hidden: show it
        execute 'below sbuffer' l:buf
    else
        " Terminal visible: hide it
        execute bufwinnr(l:buf) . 'hide'
    endif
endfunction

nnoremap <leader>` :call <SID>TermToggle()<CR>
tnoremap <leader>` <C-\><C-n>:call <SID>TermToggle()<CR>

nnoremap <leader>w :vert ter ++open ++cols=65<CR>
nnoremap <leader>W :below ter ++open ++rows=15<CR>

" Double-Esc to leave Terminal-Insert mode (single Esc passes through)
tnoremap <Esc><Esc> <C-\><C-n>

" Close terminal window when in Terminal-Normal mode
tnoremap <leader>tc <C-\><C-n><C-w><C-c>

" Auto-enter insert mode when entering a terminal buffer
autocmd BufWinEnter,WinEnter term://* startinsert

" Cursor shape: block in normal, bar in insert/replace
" DECSCUSR codes: 2=block, 6=bar, 4=underline
" Vim's builtin_terms has empty t_SI/t_EI — must set manually
if !empty($TMUX)
  " tmux: wrap escape sequences with DCS tmux passthrough
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
else
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[6 q"
  let &t_EI = "\<Esc>[2 q"
endif
