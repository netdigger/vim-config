"au BufWrite *.cpp,*.h,*.c,*.py :Autoformat
nnoremap <silent> <leader>i :Autoformat<cr>
let g:formatter_yapf_style = 'google'
" clang-format: uses .clang-format if present, falls back to Google style
" with settings derived from the current buffer
let g:formatdef_clangformat = "'clang-format
            \ -lines='.a:firstline.':'.a:lastline.'
            \ --assume-filename=\"'.expand('%:p').'\"
            \ --fallback-style=Google
            \ --sort-includes
            \ -style=\"{BasedOnStyle: Google, AlignTrailingComments: true,
            \ '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(
            \ &expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() :
            \ 'UseTab: Always').'}\"'"
