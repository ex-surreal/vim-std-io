if exists("g:plugin_ok_loaded")
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

let g:plugin_ok_input_history = {}
let g:plugin_ok_input_buffer = ""
let g:plugin_ok_output_buffer = ""
let g:plugin_ok_current_file = ""
let g:plugin_ok_current_file_buffer = ""

function! CreateIOBufferes()
    if g:plugin_ok_input_buffer ==# ""
        let g:plugin_ok_input_buffer = "ok-input"
        let g:plugin_ok_output_buffer = "ok-output"
        execute "15new ". g:plugin_ok_output_buffer
        setlocal buftype=nofile noswapfile norelativenumber switchbuf=useopen
        nnoremap <buffer> <leader>r :call RunOK()<cr>
        execute "leftabove vnew ". g:plugin_ok_input_buffer
        setlocal buftype=nofile noswapfile norelativenumber switchbuf=useopen
        nnoremap <buffer> <leader>r :call RunOK()<cr>
    endif
endfunction

function! DeleteIOBufferes()
    if g:plugin_ok_input_buffer !=# ""
        execute "bdelete " . g:plugin_ok_input_buffer
        execute "bdelete " . g:plugin_ok_output_buffer
        let g:plugin_ok_input_buffer = ""
        let g:plugin_ok_output_buffer = ""
    endif
endfunction

function! PrepareOK()
    let g:plugin_ok_current_file_buffer = expand("%")
    let g:plugin_ok_current_file = expand("%:p")
    call DeleteIOBufferes()
    call CreateIOBufferes()
    let l:input = get(g:plugin_ok_input_history, g:plugin_ok_current_file, "")
    execute "sbuffer " . g:plugin_ok_input_buffer
    silent put! =l:input
    silent $delete _
endfunction

function! RunOK()
    if g:plugin_ok_current_file ==# ""
        return
    endif
    execut "sbuffer " . g:plugin_ok_input_buffer
    let l:input = join(getline(1, "$"), "\n")
    if strlen(l:input) == 0
        return
    endif
    let g:plugin_ok_input_history[g:plugin_ok_current_file] = l:input
    silent! let l:output = system("ok " . g:plugin_ok_current_file . " <<<'" . l:input ."'")
    execut "sbuffer " . g:plugin_ok_output_buffer
    silent 1,$delete _
    silent put! =l:output
    silent $delete _
endfunction

function! PrepareAndRun()
    call PrepareOK()
    call RunOK()
endfunction

command! -nargs=0 OK call PrepareAndRun()
command! -nargs=1 OP call OpenFile('<args>')

nnoremap <leader>r :OK<cr>
nnoremap <leader>i :execute 'sbuffer' g:plugin_ok_input_buffer<cr>
nnoremap <leader>o :execute 'sbuffer' g:plugin_ok_output_buffer<cr>
nnoremap <leader>f :execute 'sbuffer' g:plugin_ok_current_file_buffer<cr>
nnoremap <leader>q :call DeleteIOBufferes()<cr>

