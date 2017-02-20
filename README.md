# vim-std-io
This is a vim plugin for running test cases for a single file which is very helpful for contest programming.

![Preview](https://raw.githubusercontent.com/ex-surreal/ex-surreal.github.io/master/images/vim-std-io-preview.png)

### Installation
Manual installation will need to download /plugin/vim-std-io.vim and source it in your .vimrc

Best way to install is to use a plugin manager. I've used this with vim-plug and it works fine. Should work with other popular plugin managers as well.

For [vim-plug](https://github.com/junegunn/vim-plug), just add this line `Plug 'ex-surreal/vim-std-io'` and run `:PlugInstall`


### Features
Basically what this plugin do is it will take test case from you in a buffer, run the current file for that case and show the output is another buffer in a clean layout. Also this plugin saves test cases, so you can navigate through history or run all the cases at once!

This plugin provides these commands

1. `:IO` (Takes one or zero argument) Opens up the i/o buffers if not already open and runs the target file with the latest test case (if any). You can then edit the test case and hit `:IO` again to run the target file with the buffer content. If you hit `:IO 1` then the target file will be run even if input buffer is empty [helpful for checking Topcoder problems with _moj_ or similar kind of plugins].

2. `:OI` Closes input and output buffer

3. `:GO` (Takes one or zero argument). Shows the previous test case in input buffer, you can then check that test case. If integer argument given then history will be shifted by that argument. For example `:GO 2` will take you 2 cases forward in history and `:GO -3` will take you 3 cases backward in history.

4. `:IOI` Magic! Runs all the test cases you've run previously! Output buffer looks like this

5. `:OP <filename>` Creates a new file with <filename> with predefined template for that file type.

6. `:UT` (Takes one or zero arguments) Opens the template in a new buffer to edit for given file type as argument (or current file type f not given).

![Preview](https://raw.githubusercontent.com/ex-surreal/ex-surreal.github.io/master/images/vim-std-io-run-all.png)

### Mappings

These mappings are by default in action. However, you can turn off these by putting `let g:std_io_map_default = 0` before you load this plugin and set your own preferable mappings.

1. `<leader>r` runs `:IO` command
2. `<leader>er` runs `:IOI` command
3. `<leader>tr` runs `:IO 1` command
4. `<leader>i` selects input buffer
5. `<leader>o` selects output buffer
6. `<leader>f` selects solution's buffer
7. `<leader>q` runs `:OI` command
8. `<leader>p` runs `:GO` command
9. `<leader>n` runs `:GO 1`

### Language Support

You can easily use this plugin for c++ or python. To set the command for any new language you must declare a dictionary. For example, if you just want to change the c++ standard to c++14 then you may put this before you load this plugin. `let g:std_io_user_command = {'cpp': "'g++ -Wall --std=c++14 -o ' . expand('%:p:r') . '.o ' . expand('%:p') . ' && ' . expand('%:p:r') . '.o'"}`.

If you wish to use any other language then you've to set the shell command to run for that language.

NOTE: This plugin will run the following vim command to generate the shell command for running the solution `execute let shell_command_to_run = get(g:std_io_user_command, &filetype, '')`. Then `<<<'<input>'` will be appended to `shell_command_to_run`.

### Extras
You can also initialize the height of the i/o buffers by putting `let g:std_io_window_height = 15` before you load this plugin.

