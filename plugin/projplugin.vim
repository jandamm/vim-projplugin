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
	au!
	autocmd BufReadPost,BufNewFile * call timer_start(0, {-> s:projplugin() })
augroup END

function! s:projplugin() abort
	let name = projplugin#name()
	if name ==? '' | return | endif
	if exists('b:projplugin_name') && b:projplugin_name ==# name
		return
	endif
	call s:source(name)
	let b:projplugin_name = name
endfunction

function! s:source(name) abort
	let path = 'projplugin/'.a:name.'.vim'
	let exe = 'runtime '.path
	if g:projplugin_silence <= 0
		let ret = ''
		redir => ret
		silent! execute 'verbose '.exe
		redir END
		if ret !=? "\nnot found in \'runtimepath\': \"".path."\""
			echom ret
			echom 'Sourced '.path
		endif
	elseif g:projplugin_silence > 1
		silent! execute exe
	else
		execute exe
	endif
endfunction
