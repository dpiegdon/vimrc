" pytyper - ALE linter that checks for missing type annotations in Python
" functions. Uses 'cat' as a passthrough so ALE feeds the buffer contents
" to the callback, where all the actual checking happens in vimscript.

call ale#Set('python_pytyper_executable', 'cat')

function! ale_linters#python#pytyper#Handle(buffer, lines) abort
	let l:output = []

	let l:i = 0
	while l:i < len(a:lines)
		let l:line = a:lines[l:i]

		if l:line =~# '^\s*\(async\s\+\)\?def\s\+'
			let l:def_start = l:i
			let l:full = l:line

			while l:full !~# ')\s*\(->\s*.\+\)\?\s*:\s*\(#.*\)\?$' && l:i + 1 < len(a:lines)
				let l:i += 1
				let l:full .= ' ' . trim(a:lines[l:i])
			endwhile

			let l:msgs = s:check_def(l:full)
			if len(l:msgs) > 0
				call add(l:output, {
				\   'lnum': l:def_start + 1,
				\   'col': 1,
				\   'text': join(l:msgs, '; '),
				\   'type': 'W',
				\ })
			endif
		endif

		let l:i += 1
	endwhile

	return l:output
endfunction

function! s:check_def(full_line) abort
	let l:msgs = []

	let l:paren_start = stridx(a:full_line, '(')
	let l:paren_end = strridx(a:full_line, ')')
	if l:paren_start < 0 || l:paren_end < 0
		return l:msgs
	endif

	let l:after_paren = strpart(a:full_line, l:paren_end + 1)
	if l:after_paren !~# '->'
		call add(l:msgs, 'missing return type')
	endif

	let l:params_str = strpart(a:full_line, l:paren_start + 1, l:paren_end - l:paren_start - 1)
	let l:untyped = s:find_untyped_params(l:params_str)
	if len(l:untyped) > 0
		call add(l:msgs, 'untyped: ' . join(l:untyped, ', '))
	endif

	return l:msgs
endfunction

function! s:find_untyped_params(params_str) abort
	let l:untyped = []
	let l:params = s:split_params(a:params_str)

	for l:param in l:params
		let l:p = trim(l:param)
		if l:p ==# ''
			continue
		endif
		" skip *, *args, **kwargs, /, self, cls
		if l:p =~# '^\*' || l:p ==# '/' || l:p ==# 'self' || l:p ==# 'cls'
			continue
		endif
		let l:eq_pos = stridx(l:p, '=')
		let l:colon_pos = stridx(l:p, ':')
		if l:colon_pos < 0 || (l:eq_pos >= 0 && l:colon_pos > l:eq_pos)
			let l:name = matchstr(l:p, '^\s*\zs\w\+')
			if l:name !=# ''
				call add(l:untyped, l:name)
			endif
		endif
	endfor

	return l:untyped
endfunction

" split parameter string respecting nested brackets/parens
function! s:split_params(str) abort
	let l:params = []
	let l:current = ''
	let l:depth = 0
	let l:i = 0

	while l:i < len(a:str)
		let l:c = a:str[l:i]
		if l:c ==# ',' && l:depth == 0
			call add(l:params, l:current)
			let l:current = ''
		else
			if l:c ==# '(' || l:c ==# '[' || l:c ==# '{'
				let l:depth += 1
			elseif l:c ==# ')' || l:c ==# ']' || l:c ==# '}'
				let l:depth -= 1
			endif
			let l:current .= l:c
		endif
		let l:i += 1
	endwhile

	if l:current !=# ''
		call add(l:params, l:current)
	endif

	return l:params
endfunction

call ale#linter#Define('python', {
\   'name': 'pytyper',
\   'executable': 'cat',
\   'command': 'cat',
\   'callback': 'ale_linters#python#pytyper#Handle',
\ })
