" CMake — uses cmake-language-server (YCM), cmakelint (ALE), cmake-format
setlocal shiftwidth=2 softtabstop=2 expandtab

" F5 = configure + build, F7 = build
nnoremap <buffer> <F5> :AsyncRun cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build<CR>
nnoremap <buffer> <F7> :AsyncRun cmake --build build<CR>
" F11 = run ctest
nnoremap <buffer> <F11> :AsyncRun ctest --test-dir build<CR>
