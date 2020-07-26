if exists('g:loaded_projplugin')
	finish
endif
let g:loaded_projplugin = 1

augroup projplugin_augroup
	au!
	autocmd BufReadPost,BufNewFile * call timer_start(0, {-> s:projplugin() })
augroup END

function! s:projplugin() abort
	let projplugin = s:getProject()
	if projplugin ==? '' | return | endif
	if exists('b:projplugin_name') && b:projplugin_name ==# projplugin
		return
	endif
	if s:sourced(projplugin)
		echom 'Sourced ' . projplugin
		let b:projplugin_name = projplugin
	endif
endfunction

function! s:sourced(name) abort
	redir => ret
	silent! execute 'verbose runtime projplugin/'.a:name.'.vim'
	redir END
	return !(exists('ret') && ret !=? '')
endfunction

function! s:getProject() abort
	return fnamemodify(s:getDir(), ':t')
endfunction

function! s:getDir() abort
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
