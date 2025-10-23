" pipe buffer contents through python code formatter `black`.
" replace output or show a new window with error message

if !exists('g:python_black_options')
	let g:python_black_options = []
	"let g:python_black_options = ['--line-length', '90', '--skip-string-normalization']
endif

function! s:BlackExitHandler(job, result)
	let l:out = ch_getbufnr(a:job, 'out')
	let l:err = ch_getbufnr(a:job, 'err')

	if a:result == 0
		let l:view = winsaveview()
		call deletebufline(bufnr('%'), 1, '$')
		" skip first line, there is a note on which i/o stream is read
		call setline(1, getbufline(l:out, 2, '$'))
		call winrestview(l:view)
	else
		botright new
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
		" skip first line, there is a note on which i/o stream is read
		call setline(1, getbufline(l:err, 2, '$'))
		resize 5
		file [black-error]
	endif

	execute 'bwipeout! ' . l:out
	execute 'bwipeout! ' . l:err
endfunction

function! s:BlackFormat()
	let l:src = join(getline(1, '$'), "\n")

	let l:stdout = []
	let l:stderr = []

	let l:job = job_start(['black', '-'] + g:python_black_options, {
				\ 'in_io': 'buffer',
				\ 'in_name': bufname(),
				\ 'out_io': 'buffer',
				\ 'out_name': '',
				\ 'err_io': 'buffer',
				\ 'err_name': '',
				\ 'exit_cb': 's:BlackExitHandler',
				\ })
endfunction

command! BlackFormat call s:BlackFormat()
