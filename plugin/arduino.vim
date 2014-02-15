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

if !exists('g:arduino_workspace')
	let g:arduino_workspace = '/Users/edward/Documents/Arduino'
endif

" ============
" Installation
" ============

" 1. Install Ino command line tool
function! arduino#install()
    echom 'Installing InoTool and required Python 2.7 libraries...'
	execute '!cd /tmp; git clone git://github.com/amperka/ino.git'
    " echom 'Mac users will need XCode installed to provide "make".'
    echom 'Python2 is required for InoTool. '
    " execute '!cd /tmp/ino; env python2 setup.py install --root / --prefix /usr/local --exec-prefix /usr/local'
    execute '!cd /tmp/ino; sudo python /tmp/ino/setup.py install --root / --prefix /usr/local --exec-prefix /usr/local'
	echom 'InoTool install complete.'
	execute '!sudo easy_install-2.7 configobj jinja2 pyserial'
endfunction

" ==================
"  Help 
" ==================

" Main Help
function! arduino#help()
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; ino --help'
endfunction

" Build Help
function! arduino#buildhelp()
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; ino build --help'
endfunction

" ==================
"  Editing Source
" ==================

function! arduino#workspace()
	execute ':e '.g:arduino_workspace
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
