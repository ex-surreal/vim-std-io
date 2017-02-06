# vim-std-io
This is a vim plugin for running test cases for a single file which is very helpful for contest programming.

### Features
Basically what this plugin do is it will take test case from you in a buffer, run the current file for that case and show the output is another buffer in a clean layout. Also this plugin saves the test case, so you can navigate through history or run all the cases at once!

![Preview](https://raw.githubusercontent.com/ex-surreal/ex-surreal.github.io/master/images/vim-std-io-preview.png)

This plugin provides **4** commands

1. `:IO` (Takes one or zero argument) Opens up the i/o buffers if not already open and runs the target file with the latest test case (if any). You can then edit the test case and hit `:IO` again to run the target file with the buffer content. If you hit `:IO 1` then the target file will be run even if input buffer is empty [helpful for checking Topcoder problems with _moj_ or similar kind of plugins].

2. `:OI` Closes input and output buffer

3. `:GO` (Takes one or zero argument). Shows the previous test case in input buffer, you can then check that test case. If integer argument given then history will be shifted by that argument. For example `:GO 2` will take you 2 cases forward in history and `:GO -3` will take you 3 cases backward in history.

4. `:IOI` Magic! Runs all the test cases you've run previously! Output buffer looks like this

![Preview](https://raw.githubusercontent.com/ex-surreal/ex-surreal.github.io/master/images/vim-std-io-run-all.png)

### Mappings

These mappings are by default in action. However, you can turn off these by putting `let g:std_io_map_default = 0` before you load this plugin.
 
```
nnoremap <silent> <leader>r :IO<cr>
nnoremap <silent> <leader>er :IOI<cr>
nnoremap <silent> <leader>tr :IO 1<cr>
nnoremap <silent> <leader>i :execute 'sbuffer' g:std_io_input_buffer<cr>
nnoremap <silent> <leader>o :execute 'sbuffer' g:std_io_output_buffer<cr>
nnoremap <silent> <leader>f :execute 'sbuffer' g:std_io_current_file_buffer<cr>
nnoremap <silent> <leader>q :OI<cr>
nnoremap <silent> <leader>p :GO<cr>
nnoremap <silent> <leader>n :GO 1<cr>
```

### Language Support

You can easily use this plugin for c++ or python. To set the command for any new language you must declare a dictionary. For example, if you just want to change the c++ standard to c++14 then you may put this before you load this plugin. `let g:std_io_user_command = {'cpp': "'g++ -Wall --std=c++14 -o ' . expand('%:p:r') . '.o ' . expand('%:p') . ' && ' . expand('%:p:r') . '.o'"}`.

If you wish to use any other language then you've to set the command to run for that language.

NOTE: This plugin will run the following vim command to generate the shell command for running the solution `execute let shell_command_to_run = get(g:std_io_user_command, &filetype, '')`. Then `<<<'<input>'` will be appended to `shell_command_to_run`.

### Extras
You can also initialize the height of the i/o buffers by putting `let g:std_io_window_height = 15` before you load this plugin.

