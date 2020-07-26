autocmd BufReadPost,BufNewFile * call timer_start(0, {-> s:projplugin() })

function! s:projplugin() abort
	echo 'projplug ' . s:getDir()
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
