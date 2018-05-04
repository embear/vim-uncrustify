" Name:    unrustify.vim
" Version: 0.0.1
" Author:  Markus Braun <markus.braun@krawel.de>
" Summary: Vim plugin to enable proper use of uncrustify
" Licence: This program is free software: you can redistribute it and/or modify
"          it under the terms of the GNU General Public License as published by
"          the Free Software Foundation, either version 3 of the License, or
"          (at your option) any later version.
"
"          This program is distributed in the hope that it will be useful,
"          but WITHOUT ANY WARRANTY; without even the implied warranty of
"          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"          GNU General Public License for more details.
"
"          You should have received a copy of the GNU General Public License
"          along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" Section: Plugin header {{{1

" Guard against multiple loads {{{2
if (exists("g:loaded_uncrustify") || &cp)
  finish
endif
let g:loaded_uncrustify = 1

" Define default "g:uncrustify_command" {{{2
if !exists("g:uncrustify_command")
  let g:uncrustify_command = "uncrustify"
endif

" Define default "g:uncrustify_config_file" {{{2
if !exists("g:uncrustify_config_file")
  let g:uncrustify_config_file = "~/.uncrustify.cfg"
endif

" Define default "g:uncrustify_language_mapping" {{{2
if !exists("g:uncrustify_language_mapping")
  let g:uncrustify_language_mapping = { "c" : "c", "cpp": "cpp", "objc": "oc", "objcpp": "oc+", "cs": "cs", "java": "java" }
endif

" Define default "g:uncrustify_debug" {{{2
if !exists("g:uncrustify_debug")
  let g:uncrustify_debug = 0
endif

" Section: Functions {{{1

" Function: s:UncrustifyPreserve() {{{2
"
" Restore cursor position, window position and last search after running a
" command.
"
function! s:UncrustifyPreserve(command)
  " Save the last search.
  let l:search = @/

  " Save the current cursor position.
  let l:cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let l:window_position = getpos('.')
  call setpos('.', l:cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = l:search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', l:cursor_position)
endfunction


" Function: Uncrustify() {{{2
"
" Execute uncrustify for current buffer
"
function! Uncrustify()
  let l:uncrustify_config_file_path = shellescape(fnamemodify(g:uncrustify_config_file, ':p'))

  if executable(g:uncrustify_command)
    if has_key(g:uncrustify_language_mapping, &filetype)
      let l:command = 
            \   ':silent! %!' . g:uncrustify_command
            \ . ' -q '
            \ . ' -l ' . g:uncrustify_language_mapping[&filetype]
            \ . ' -c ' . l:uncrustify_config_file_path
      call s:UncrustifyDebug(1, "command " . command)
      call s:UncrustifyPreserve(l:command)
    else
      call s:UncrustifyError("No language mapping for filetype " . &filetype)
    endif
  else
    call s:UncrustifyError("No uncrustify executable")
  endif
endfunction


" Function: s:UncrustifyError(text) {{{2
"
" Output error message.
"
function! s:UncrustifyError(text)
  echohl ErrorMsg | echom "uncrustify: " . a:text | echohl None
endfunction


" Function: s:UncrustifyDebug(level, text) {{{2
"
" Output debug message, if this message has high enough importance.
"
function! s:UncrustifyDebug(level, text)
  if (g:uncrustify_debug >= a:level)
    echom "uncrustify: " . a:text
  endif
endfunction


" Section: Commands {{{1
command! Uncrustify :call Uncrustify()

" vim600: foldmethod=marker foldlevel=0 :
