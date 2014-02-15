" arduino.vim
" Author:  edthedev
" URL:     https://github.com/edthedev/arduino.vim
" Version: 0.0.1
" License: Same as Vim itself (see :help license)
"
"
" ============
" Installation
" ============

" 1. Install Ino command line tool
function! arduino#install()
    echom 'Installing InoTool...'
	execute '!cd /tmp; git clone git://github.com/amperka/ino.git'
    " echom 'Mac users will need XCode installed to provide "make".'
    echom 'Python2 is required for InoTool. '
    " execute '!cd /tmp/ino; env python2 setup.py install --root / --prefix /usr/local --exec-prefix /usr/local'
    execute '!cd /tmp/ino; sudo python /tmp/ino/setup.py install --root / --prefix /usr/local --exec-prefix /usr/local'
	echom 'InoTool install complete.'
endfunction

" Help
function! arduino#help()
    echom 'Installing InoTool...'
	execute '!ino --help'
endfunction

" ==================
" Keyboard Mappings
" ==================

" Map keyboard shortcuts by default.
if !exists('g:arduino_map_keys')
	let g:arduino_map_keys = 1
endif

if g:arduino_map_keys
    " Install 

    :nnoremap <leader>ai :call arduino#install()<Cr>
endif
