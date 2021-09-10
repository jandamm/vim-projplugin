if exists('g:loaded_projplugin')
	finish
endif
let g:loaded_projplugin = 1

augroup projplugin_augroup
	autocmd!
	autocmd WinEnter,BufReadPost,BufNewFile * call timer_start(0, {-> projplugin#load() })
augroup END
