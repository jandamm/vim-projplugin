if exists('g:loaded_projplugin')
	finish
endif
let g:loaded_projplugin = 1

" Silence modes
" 0 - Show message for sourcing and echo from sourced file
" 1 - Just output what the projplugin generates
" 2 - Show nothing (not even echo in sourced file)
if !exists('g:projplugin_silence')
	let g:projplugin_silence = 1
endif

augroup projplugin_augroup
	autocmd!
	autocmd BufReadPost,BufNewFile * call timer_start(0, {-> projplugin#load() })
augroup END
