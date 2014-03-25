" arduino.vim
" Author:  edthedev
" URL:     https://github.com/edthedev/arduino.vim
" Version: 0.0.1
" License: Same as Vim itself (see :help license)
"
let s:path = expand('<sfile>:p:h')

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

" Solution for 'Programmer not responding on OSX 10.9
"     cd /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns
"         sudo mv AppleUSBFTDI.kext AppleUSBFTDI.disabled
"             sudo touch /System/Library/Extensions


" execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path

" ==================
"  Help 
" ==================

" Main Help
function! arduino#help()
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; ino --help'
endfunction

" Build Help
function! arduino#help()
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; ino build --help'
endfunction

" ==================
"  Editing Source
" ==================

function! arduino#workspace()
	execute ':e '.g:arduino_workspace
endfunction

" TODO: In progress...Init a new Ino directory
" Do this on the command line, for now.
function! arduino#init()
	let s:project_path = expand('%:p:h')
	" let s:project_name = expand('%:r')
	" execute ':e '.g:arduino_workspace
	" execute '!mkdir -p '.s:project_path.'/'.s:project_name
	" execute '!cd '.s:project_path.'/'.s:project_name.'; ino init'
	execute '!cd '.s:project_path.'; ino init'
endfunction

" ProTip: Build only works after the first time you ino init
function! arduino#build()
	let s:project_path = expand('%:p:h')
	" echom 'Project path is '.s:project_path
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; cd '.s:project_path.'; ino build'
	" execute '!cd '.s:project_path.'; ino build'
endfunction

" ProTip: Upload after you build. 
function! arduino#upload()
	let s:project_path = expand('%:p:h')
	" echom 'Project path is '.s:project_path
	execute '!export PYTHONPATH=$PYHONPATH:'.g:ino_lib_path.'; cd '.s:project_path.'; ino upload'
endfunction

if !exists('g:arduino_library_path')
	let g:arduino_library_path = '~/Documents/Arduino/libraries'
endif

function! arduino#open_library()
	" Add the library folder as a buffer.
	execute ':badd '.g:arduino_library_path
	" List buffers to remind us it worked.
	execute ':buffers'
endfunction

" Recognize ino and pde files as C++.
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" Commands

" ==================
" Keyboard Mappings
" ==================

" Map keyboard shortcuts by default.
if !exists('g:arduino_map_keys')
	let g:arduino_map_keys = 1
endif

if g:arduino_map_keys
    " Install 

    :nnoremap <leader>ab :call arduino#build()<Cr>
    :nnoremap <leader>au :call arduino#upload()<Cr>
    :nnoremap <leader>ai :call arduino#init()<Cr>
    :nnoremap <leader>al :call arduino#open_library()<Cr>
    :nnoremap <leader>aw :call arduino#workspace()<Cr>
endif
