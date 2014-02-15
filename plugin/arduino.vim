" arduino.vim
" Author:  edthedev
" URL:     https://github.com/edthedev/arduino.vim
" Version: 0.0.1
" License: Same as Vim itself (see :help license)
"
"
if !exists('g:ino_lib_path')
	let g:ino_lib_path = '/usr/local/lib/python2.6/site-packages/'
endif

execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; ino build --help'


if !has('python')
	echo "Error: Arduino.vim requires vim compiled with +python"
		finish
	endif

let s:path = expand('<sfile>:p:h')

" Setup for Python library imports.
python << endpython
import sys
import os
import vim

ino_lib_path = '/usr/local/lib/python2.6/site-packages/'
sys.path.insert(0, ino_lib_path)

script_path = vim.eval('s:path')
lib_path = os.path.join(script_path, '..')
sys.path.insert(0, lib_path)

import ino

endpython

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
