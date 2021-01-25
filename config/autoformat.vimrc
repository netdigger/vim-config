"au BufWrite *.cpp,*.h,*.c,*.py :Autoformat
noremap <leader>i :Autoformat<cr>
let g:formatter_yapf_style = 'google'
let g:formatdef_clangformat = "'clang-format
            \ -lines='.a:firstline.':'.a:lastline.'
            \ --assume-filename=\"'.expand('%:p').'\"
            \ -style=file'"
"let g:formatdef_clangformat = "'clang-format
"            \ -lines='.a:firstline.':'.a:lastline.'
"            \ --assume-filename=\"'.expand('%:p').'\"
"            \ -style=\"{BasedOnStyle: Google, AlignTrailingComments: true,
"            \ '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(
"            \ &expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() :
"            \ 'UseTab: Always').'}\"'"
