"ALE
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_echo_msg_format = '[%severity%] %code: %%s [%linter%] '
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
"let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_statusline_format = ['✗•%d', '⚡•%d', '✔ OK']
let g:ale_c_gcc_options = '-Wall -Wextra -O0 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -Wextra -O0 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
"let g:ale_open_list = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚡'
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi SpellBad gui=undercurl guisp=red
hi SpellCap gui=undercurl guisp=blue
hi SpellRare gui=undercurl guisp=magenta
hi clear SignColumn
hi ALEErrorSign guibg=darkgray ctermfg=red
hi ALEWarningSign guibg=darkgray ctermfg = yellow
let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['build', 'release', 'debug']
let g:ale_linters = {'cpp': ['clang']}

