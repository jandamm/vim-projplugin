if exists('g:loaded_projplugin')
	finish
endif
let g:loaded_projplugin = 1

augroup projplugin_augroup
	au!
	autocmd BufReadPost,BufNewFile * call timer_start(0, {-> s:projplugin() })
augroup END

function! s:projplugin() abort
	let name = projplugin#name()
	if name ==? '' | return | endif
	if exists('b:projplugin_name') && b:projplugin_name ==# name
		return
	endif
	if s:sourced(name)
		echom 'Sourced ' . name
		let b:projplugin_name = name
	endif
endfunction

function! s:sourced(name) abort
	redir => ret
	silent! execute 'verbose runtime projplugin/'.a:name.'.vim'
	redir END
	return !(exists('ret') && ret !=? '')
endfunction
