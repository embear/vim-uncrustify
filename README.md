# Uncrustify

This plugin provides functions and commands to ease the use of uncrustify
within Vim.

The plugin can be found on [Bitbucket], [GitHub] and [VIM online].

## Commands

### The `Uncrustify` command

Run uncrustify on current buffer.

## Functions

### The `Uncrustify` function

Run uncrustify on current buffer. This function can be used to add an
autocommand that formats the code automatically on write.

``` {.vim}
autocmd BufWritePre * if (&filetype == 'cpp') | call Uncrustify() | endif
```

## Settings

### The `g:uncrustify_command` setting

Command that will be run.

  - Default: `"uncrustify" ]`

### The `g:uncrustify_config_file` setting

Configuration that will be used to run uncrustify.

  - Default: `"~/.uncrustify.cfg" ]`

### The `g:uncrustify_language_mapping` setting

Dictionary that contains the mapping from Vim buffer file type to uncrustify
language.

  - Default: `{ "c" : "c", "cpp": "cpp", "objc": "oc", "objcpp": "oc+", "cs": "cs", "java": "java" }`

### The `g:uncrustify_debug` setting

Debug level for this script.

  - Default: `0`

## Contribute

To contact the author (Markus Braun), please send an email to <markus.braun@krawel.de>

If you think this plugin could be improved, fork on [Bitbucket] or [GitHub] and
send a pull request or just tell me your ideas.

## Credits

- Alexander Shukaev for his post on stack overflow about uncrustify and Vim

## Changelog

v0.0.1 : XXXX-XX-XX

  - initial release.

[Bitbucket]: https://bitbucket.org/embear/uncrustify
[GitHub]: https://github.com/embear/vim-uncrustify
[VIM online]: http://www.vim.org/scripts/script.php?script_id=441
