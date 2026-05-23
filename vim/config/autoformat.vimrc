"au BufWrite *.cpp,*.h,*.c,*.py :Autoformat
nnoremap <silent> <leader>i :Autoformat<cr>
let g:formatter_yapf_style = 'google'

" clang-format: uses .clang-format if present, falls back to vim buffer settings
function! g:ClangFormatConfigFileExists()
    return len(findfile('.clang-format', expand('%:p:h').';'))
endfunction

let s:cfg_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
let s:nocfg_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" --fallback-style=Google --sort-includes -style=\"{BasedOnStyle: Google, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
let g:formatdef_clangformat = "g:ClangFormatConfigFileExists() ? (" . s:cfg_def . ") : (" . s:nocfg_def . ")"
