if exists('g:autoloaded_projplugin')
	finish
endif
let g:autoloaded_projplugin = 1

function! projplugin#load() abort
	let name = s:getName()
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

function! s:getName() abort
	let path = s:getPath()
	let name = ''
	if exists('*ProjpluginName')
		let name = ProjpluginName(path)
	endif
	if type(name) == type('') && name !=? ''
		return name
	endif
	return fnamemodify(path, ':t')
endfunction

function! s:getPath() abort
	" Use vim-rooter if possible
	if exists('*FindRootDirectory')
		return FindRootDirectory()
	else
		return getcwd()
	endif
endfunction
