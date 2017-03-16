let s:cpo = &cpo
set cpo&vim

let s:windows = has('win64') || has('win32') || has('win16') || has('win95')

if !exists('g:findinclude#envname')
  let g:findinclude#envname = s:windows ? 'INCLUDE' : 'CPATH'
endif
if !exists('g:findinclude#envsep')
  let g:findinclude#envsep = s:windows ? ';' : ':'
endif
if !exists('g:findinclude#grepoption')
  let g:findinclude#grepoption = ''
endif
if !exists('g:findinclude#globsuffix')
  let g:findinclude#globsuffix = '**'
endif
if !exists('g:findinclude#uselocationlist')
  let g:findinclude#uselocationlist = 0
endif

function! findinclude#escapepath(path)
  return substitute(a:path, '\s', '\\\0', 'g')
endfunction
function! findinclude#joinpath(root, ...)
  let sep = matchstr(a:root, '\v(/|\\)')
  if empty(sep)
    let sep = '/'
  endif
  return join(extend([substitute(a:root, '\v(/|\\)$', '', '')],
    \ map(copy(a:000), 'substitute(v:val, "\\v(/|\\\\)", sep, "g")')), sep)
endfunction
function! findinclude#vimgrep(pattern)
  execute printf('let include=$%s', g:findinclude#envname)
  if empty(include)
    throw printf('FindInclude: %s environmnet variable is not set on your machine.',
      \ g:findinclude#envname)
  endif
  let grepcmd = g:findinclude#uselocationlist ? 'lvimgrep' : 'vimgrep'
  let c = 0
  for d in split(include, printf('\s*%s\s*', g:findinclude#envsep))
    try
      execute printf('%s%s /%s/%s %s', grepcmd, c > 0 ? 'add' : '',
        \ substitute(a:pattern, '/', '\\\0' ,'g'), g:findinclude#grepoption,
        \ findinclude#escapepath(findinclude#joinpath(d, g:findinclude#globsuffix)))
    catch /\v^Vim\((l)?vimgrep(add)?\):\s*E480:/
      " NOP
    catch
      echoerr v:exception
    endtry
    let c += 1
  endfor
endfunction

let &cpo = s:cpo
unlet! cpo
