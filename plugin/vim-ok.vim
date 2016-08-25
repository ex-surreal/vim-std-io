if !exists("g:plugin_ok_loaded")
    finish
endif
let g:plugin_ok_loaded = 1

function! OpenFile(file)
    if a:file ==# ""
        return
    endif
    silent call system("ok -os " . a:file)
    if v:shell_error != 0
        return
    endif
    silent! execute 'edit +/main ' . a:file
endfunction

command! -nargs=1 OP call OpenFile('<args>')


