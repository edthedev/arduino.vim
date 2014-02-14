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
    execute '!cd /tmp/ino; make install'
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
