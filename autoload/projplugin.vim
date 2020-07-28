if exists('g:autoloaded_projplugin')
	finish
endif
let g:autoloaded_projplugin = 1

function! projplugin#name() abort
	let ret = s:getName()
	if type(ret) != type('') || ret ==? ''
		let ret = fnamemodify(projplugin#path(), ':t')
	endif
	return ret
endfunction

function! s:getName() abort
	if exists('*ProjpluginName')
		return ProjpluginName(projplugin#path())
	endif
endfunction

function! projplugin#path() abort
	" Use vim-rooter if possible
	if exists('*FindRootDirectory')
		return FindRootDirectory()
	else
		redir => ret
		silent! pwd
		redir END
		return substitute(ret, '^\n', '', '')
	endif
endfunction
