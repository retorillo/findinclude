# findinclude.vim

Run `vimgrep` or `lvimgrep` for all files on directories specified by enrivoment
variable like `CPATH` (Linux `gcc`) or `INCLUDE` (Windows `cl`). Collected lines
are stored on Quickfix or location list.

## Install (Pathogen)

```bash
git clone https://github.com/retorillo/findinclude.vim ~/.vim/bundle/findinclude.vim
```

## Usage

```viml
:FindInclude vim-regular-expression
```

`FindInclude` might take a long time. Can press `<CTRL-C>` to interrupt if the
expected result already had been acquired. (Quickfix entries accumulated does
not lose by cancel)

## Options

The following global variables may solve your enviromental problems.

```viml
" Change enviroment variable name
" Default value is 'INCLUDE' for Windows, 'CPATH' for Linux
let g:findinclude#envname = '_INCLUDE_'

" Change separator for INCLUDE
" Default value is ';' for Windows, ':' for Linux
let g:findinclude#envsep = ':'

" Vimgrep options ('g', 'i', or both)
" Default value is '' (empty string)
let g:findinclude#grepoption = 'gi'

" Suffix that will be appended to glob-pattern for each directory
" Default value is '**/*'.
let g:findinclude#globsuffix = '**/*.h'

" Use Location list instead of Quickfix
" Default value is 0
let g:findinclude#uselocationlist = 1
```

## License

The MIT License

Copyright (C) 2017 Retorillo
