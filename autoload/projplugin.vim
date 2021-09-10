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
	execute 'runtime projplugin/'.name.'.vim'
	if has('nvim-0.5')
		execute 'runtime projplugin/'.name.'.lua'
	endif
	let b:projplugin_name = name
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
