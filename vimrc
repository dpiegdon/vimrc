" vim yay :)

" ===========================================================================
" Documentation
" ===========================================================================
" Documentation links:
" (jump to files with `gf`)
"   - README.md
"   - cheats.txt
"   - pathogens/enabled/ale.git/doc/ale.txt
"   - pathogens/enabled/fugitive.git/doc/fugitive.txt
"   - pathogens/enabled/gitgutter.vim/doc/gitgutter.txt
"   - pathogens/enabled/gundo.git/doc/gundo.txt
"   - pathogens/enabled/gv.git/README.md
"   - pathogens/enabled/rainbow_parentheses.git/README.md
"   - pathogens/enabled/repeat.git/README.markdown
"   - pathogens/enabled/tabular.git/doc/Tabular.txt
"   - pathogens/enabled/tagbar.git/doc/tagbar.txt
"   - pathogens/enabled/unimpaired.git/doc/unimpaired.txt
"   - pathogens/enabled/vim-colors-solarized/doc/solarized.txt

" press `K` to get help on wor under cursor (runs keywordprg)

" ===========================================================================
" Global Setup
" ===========================================================================
execute pathogen#infect('pathogens/enabled/{}')
					" load contained plugins

set nocompatible			" avoid legacy from vi
set cpoptions-=cM			" especially for search patterns
set maxmempattern=4096			" allow larger search patterns


set viminfo+=n~/.vim/nonpersistent/viminfo
					" use vimrc-tree internal PATHs
set undodir=~/.vim/nonpersistent/undofiles
set undofile

set shiftwidth=8			" one indent is 8 spaces
set tabstop=8				" one tab is 8 spaces
set noexpandtab				" never expand tabs
set backspace=indent,eol,start		" allow backspacing over everything
					" in insert-mode
set nojoinspaces			" do not insert two spaces after
					" each period on joined lines
function ShortTab()			" follow PEP8 for python code
	setlocal expandtab
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal softtabstop=4
endfunction

if has('wildmenu')
	set wildmenu			" use wildmenu for command-completition
	set wildmode=longest,full	" full featured
	set wildoptions=fuzzy,pum	" use fuzzy matching, use popup menu everywhere
	set wildignorecase		" ignore cases when completing files and dirs
endif

"set hl=8u				" underline meta / special key (:map)
set ruler				" always show ruler
set showcmd				" show partially completed commands
"set hidden				" show/allow hidden buffers
set hlsearch				" highlight searches
set incsearch				" incremental search
"set nowrapscan				" search doesn't wrap around
"set smartcase				" smart case analysis when searching
set listchars=tab:.\ ,eol:$,trail:.	" listmode setup ("set list" to enable)
set showfulltag				" show both the tag name and a
					" tidied-up form of the search pattern
set showmatch				" blink corresponding bracket when
					" inserting one
set number				" show line numbers
set relativenumber			" show relative line numbers
set matchtime=1				" Tenths of a sec to show matching paren
set scrolloff=2				" Scroll when 2 lines before bottom
					" of the terminal
set sidescroll=4			" or 4 chars to the side of the terminal
set splitbelow				" when splitting, move new to bottom
set splitright				" when Vsplitting, move new to right
					" printer options

set laststatus=1			" status bar: show ...
					"    0=> never
					"    1=> only if more than 1 window
					"    2=> always

set printoptions=paper:A4,duplex:on,wrap:y,syntax:y
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=utf-8
endif

" enable mouse support in xterm (set mouse= to disable)
set mouse=nvch

" spell checking - toggle visibility via unimpaired with `yos`
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
					" auto-download missing spellfiles
					" from there
setlocal spelllang=en,de
					" en_US,en_GB,en,de
set spellsuggest=double
set spellfile=~/.vim/nonpersistent/vimspell.utf-8.add

" ===========================================================================
" Syntax Highlighting and Visuals
" ===========================================================================
syntax on				" enable syntax highlighting

"set whichwrap=b,s,h,l,\<,\>,~,[,]	" which movements wrap around?
"language messages en_US.UTF-8		" English messages only

" => help ft-c-syntax
let c_gnu=1				" highlight GNU gcc specific items
let c_comment_strings=1			" highlight strings and cumbers inside comments
let c_space_errors=1			" syntax-specific tweaks
let c_curly_error=1			" highlight missing braces
let c_functions=1			" highlight function calls and definitions
let c_function_pointers=1		" highlight function pointer definitions

let c_no_comment_fold=1			" don't fold comments

"let g:load_doxygen_syntax=1		" enable doxygen syntax/formatting
"let g:tex_flavor="latex"
"let g:tex_indent_brace=0
"

if has("gui_running")
	let g:solarized_menu=0		" colorscheme options
	let g:solarized_degrade=0	" use same scheme as for 256-color term
	set guioptions=acg		" a: Visually highlighted text is available
					"    for pasting into other applications
					"    as well as into Vim itself.
					" c: Use console dialogs instead of
					"    popup dialogs for simple choices
					" g: grey out inactive menus instead
					"    of hiding them
	set guifont=Monoid\ 9

	" https://vi.stackexchange.com/questions/3093/how-can-i-change-the-font-size-in-gvim
	function! FontSizePlus()
		let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole + 1
		let l:new_font_size = ' '.l:gf_size_whole
		let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
	endfunction

	function! FontSizeMinus()
		let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
		let l:gf_size_whole = l:gf_size_whole - 1
		let l:new_font_size = ' '.l:gf_size_whole
		let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
	endfunction
else
	set t_Co=256			" use 256 colors (xterm)
	let g:solarized_termcolors=256
endif

" most are {low,normal,high}
let g:solarized_contrast="high"
let g:solarized_visibility="high"
let g:solarized_diffmode="high"
let g:solarized_errormode="high"
let g:loaded_togglebg=1

" good schemes:		brightness:	contrast:
" --------------------  --------------  ----------
" solarized		dark/light	medium
" wildcharm		dark/light	high
" molokai		dark		high
" badwolf		dark		high
" inkpot		dark		high

function ColorSchemeActivate()
	exe "set bg=" . g:bg_color
	exe "colorscheme " . g:colorscheme

	" reset sign column colors. without, signs are barely visible (e.g. GitGutter)
	au ColorScheme * highlight clear SignColumn
endfunction

function ColorSchemeNextBrightness()
	if( g:bg_color == "dark" )
		let g:bg_color="light"
	else
		let g:bg_color="dark"
	endif
	call ColorSchemeActivate()
endfunction

function ColorSchemeNext()
	if( g:colorscheme == "solarized" )
		let g:colorscheme="wildcharm"
	elseif( g:colorscheme == "wildcharm" )
		let g:colorscheme="molokai"
	else
		let g:colorscheme="solarized"
	endif
	call ColorSchemeActivate()
endfunction

let g:bg_color = "dark"
let g:colorscheme = "solarized"
call ColorSchemeActivate()

" ===========================================================================
" Autocompletion, Indexing
" ===========================================================================
"set completeopt=

" ctags and cscope stuff
set tags=./tags;./cscope.out;/
set cscopetag				" use cscope and ctags for
					" <C-]>, :ta and ``vim -t``
set cscopetagorder=0			" prefer cscope over ctags
if filereadable("cscope.out")		" add cscope db in PWD
	cs add cscope.out
endif
set cscopeverbose			" show msg when other DB added

" ===========================================================================
" Filebrowser (netrq) Setup
" ===========================================================================
let g:netrw_liststyle = 3
"let g:netrw_banner = 1
let g:netrw_browse_split = 2
let g:netrw_winsize = 25
let g:netrw_home="~/.vim/nonpersistent"

" ===========================================================================
" Gitgutter Setup
" ===========================================================================
let g:gitgutter_enabled = 0
let g:gitgutter_diff_args = '-w -b --ignore-blank-lines --ignore-space-at-eol'
					" ignore any whitespace-changes in gitgutter

" ===========================================================================
" Gundo Setup
" ===========================================================================
let g:gundo_right = '1'			" show undo-tag on right side
let g:gundo_prefer_python3 = '1'	" python3 must be used on recent distros

" ===========================================================================
" RainbowParentheses Setup
" ===========================================================================
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" ===========================================================================
" Debugging & GDB Plugin
" ===========================================================================
"packadd termdebug
let g:termdebug_config = {}
let g:termdebug_config['disasm_window'] = 1
let g:termdebug_config['disasm_window_height'] = 10
let g:termdebug_config['wide'] = 100
let g:termdebug_config['winbar'] = 0

" ===========================================================================
" Filespecific Context Setup
" ===========================================================================
runtime ftplugin/man.vim

filetype on				" autorecognize filetypes
filetype plugin on			" autoload filetype-specific plugin
filetype indent on			" auto-indent according to filetype

if has("autocmd")
	augroup remember_position	" remember cursor position in files
		au BufReadPost *
			\     if line("'\"") > 0 && line ("'\"") <= line("$") |
			\         exe "normal g'\"" |
			\     endif |
	augroup end

	augroup fugitive
		" remove old fugitive buffers
		au BufReadPost fugitive://* set bufhidden=delete
	augroup end

	augroup recognize_filetype
		au BufRead,BufNewFile *.{bsd,bsdl}            set filetype=bsdl
		au BufRead,BufNewFile *.{svf}                 set filetype=svf
		au BufRead,BufNewFile *.{bb,bbappend,bbclass} set filetype=bitbake
		au BufReadPre         *.nfo                   set fileencodings=cp437
	augroup end

	augroup filetypes
		au filetype c,cpp,python,verilog RainbowParentheses

		au filetype cpp setlocal colorcolumn=100
		au filetype lpc setlocal colorcolumn=100
		au filetype c   setlocal colorcolumn=80
		au filetype vim setlocal colorcolumn=78

		au filetype python setlocal colorcolumn=80,110
		au filetype python call ShortTab()


		au filetype diff setlocal nomodeline

		" to use vim as manpage reader:
		"   alias man=vimman
		"   vimman() { vim -c ":Man $1 $2 $3" -c ":only" }
		au filetype man  setlocal readonly
		au filetype man  setlocal nomodeline
		au filetype man  nmap     <Up>    <C-Y>
		au filetype man  nmap     <Down>  <C-E>
		au filetype man  nmap     <Space> <PageDown>
		au filetype man  nmap     <Home>  gg
		au filetype man  nmap     <End>   G
		au filetype man  nnoremap q       :quit<CR>

		au filetype mail setlocal tw=72
		au filetype mail setlocal colorcolumn=72
		au filetype mail setlocal formatoptions+=a
		au filetype mail setlocal nomodeline
		au filetype mail setlocal list
		au filetype mail setlocal listchars=tab:.\ ,eol:$,trail:.
		au filetype mail nnoremap <leader>pl :g/^>/s/  *\([!?,.]\)/\1/g<CR>
					" kill plenking in quotes
		au filetype mail nnoremap <leader>=      :set tw+=2<cr>gqip
		au filetype mail vnoremap <leader>= <Esc>:set tw+=2<cr>gvgqgv
					" reformat mails
	augroup end
endif

" ===========================================================================
" Key Bindings
" ===========================================================================
let mapleader=""
					" use default leader (backslash)

" yank across sessions
" setup register 'g' for global yanking via <leader>y and <leader>p
" see http://vim.wikia.com/wiki/Copy_and_paste_between_Vim_instances
vmap <leader>y "gy<CR>:wviminfo!<CR>
nmap <leader>p :rviminfo!<CR>"gp


nnoremap <leader>?? :echo "1:TagBar 2:Gundo 3:GitGutter 4:GStatus 5:GV 6:BGColor 7:Paste\n%:Tig:CurrentFile ^:Colorscheme\nw:WhiteSpace xX:Hex i:IntInc d:IntDec m:make ?C:Cscope Cf:indent ?q:quickfix ?L:linter"<CR>

nmap <silent> <leader>\ :nohlsearch<CR>
					" hide hilights

nnoremap <leader>?1 :split ~/.vim/pathogens/setups/tagbar.git/doc/tagbar.txt<CR>
nnoremap <leader>1 :TagbarToggle<cr>
					" toggle tagbar

nnoremap <leader>?2 :split ~/.vim/pathogens/setups/gundo.git/doc/gundo.txt<CR>
nnoremap <leader>2 :GundoToggle<cr>
					" toggle undo-history as tree

let g:gitgutter_map_keys=0		" no gitgutter mappings except:
nnoremap <leader>?3 :split ~/.vim/pathogens/setups/gitgutter.vim/doc/gitgutter.txt<CR>
nnoremap <leader>3 :GitGutterToggle<cr>
					" toggle GitGutter

nnoremap <leader>4 :Git<CR>
nnoremap <leader>?4 :split ~/.vim/pathogens/setups/fugitive.git/doc/fugitive.txt<CR>
					" show git status

nnoremap <leader>5 :GV   -- <C-R>%<CR>
nnoremap <leader>?5 :split ~/.vim/pathogens/setups/gv.git/README.md<CR>
					" prompt for gv on current file

nnoremap <silent> <leader>6 :call ColorSchemeNextBrightness()<CR>
nnoremap <silent> <leader>^ :call ColorSchemeNext()<CR>

set pastetoggle=<leader>7
					" toggle paste mode

nnoremap <leader>% :!tig   -- <C-R>%
nnoremap <leader>?% :!man tig<CR>
					" prompt for tig on current file
function ToggleDiffOption(option)
	if ( &diffopt =~# a:option )
		exe "set diffopt-=".a:option
	else
		exe "set diffopt+=".a:option
	endif
endfunction
nnoremap <leader>= :call ToggleDiffOption('iwhiteall')<CR>

nnoremap <leader>[ :n<CR>
nnoremap <leader>] :N<CR>
					" next/previous file

nnoremap <leader>a [czz
nnoremap <leader>s ]czz
					" jump to next diff and center it

nnoremap <leader>/ /^[<>\|=]\{7}<CR>
					" find diff conflicts

nnoremap <leader>D :Gvdiffsplit!<CR>
					" 3-way fugitive diff split of
					" conflicts

nnoremap <silent> <leader><tab> :call ShortTab()<CR>

if has("gui_running")

	nnoremap <leader>- :call FontSizeMinus()<CR>
	nnoremap <leader>+ :call FontSizePlus()<CR>
endif
noremap! <C-R>\ <C-R>=fnameescape(expand('%:h')).'/'<cr>
					" insert directory of current file
					" (in prompts)
nnoremap <leader>. :Explore<CR>
					" explore directory of current file
nnoremap <leader>> :Sex!<CR>
					" explore directory of current file in vsplit

nnoremap <leader>w :%s/[ \t]*$//g<CR>
					" kill any whitespace at all EOL

nnoremap <leader>x :%!xxd -g 1<CR>
nnoremap <leader>X :%!xxd -g 1 -r <CR>
					" globally convert between RAW and HEX
					" (":set binary" or "vim -b <file>")

nnoremap <leader>i <C-a>
					" increase number under cursor
nnoremap <leader>d <C-x>
					" decrease number under cursor


" autocompletion, execution and indexing tools

nnoremap <leader>m :make\|copen<CR>
					" make and open quickfix list with errors

nnoremap <leader>?C :echo "Ci - create cscope index\nCc - run cscope+ctags on cwd\nCd - clear cscope/ctag files in cwd\nC(sSV)(sgdctefi) - ctag/cscope (search,Split,Vsplit) (Symbol,Global,D:callee,Caller,liTeral,Egrep,File,Includer)\nCf - run indent on marked block"<CR>

nnoremap <leader>Ci :exe "!/usr/bin/find . -type f \\\( -name \\\*.c -o -name \\\*.h \\\) > cscope.files"<CR>
nnoremap <leader>Cc :exe "!cscope -b -q -k ; ctags -R"<CR>
nnoremap <leader>Cd :exe "!rm -vf cscope.files cscope.out cscope.in.out cscope.po.out tags"<CR>

" search for:
" s: symbol			g: global definition
" d: functions callee		c: functions caller
" t: literal string		e: egrep pattern
" f: file			i: #includers
nnoremap <leader>Css :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Csg :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Csd :cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Csc :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Cst :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Cse :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>Csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>Csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" and split
nnoremap <leader>CSs :scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSg :scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSd :scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSc :scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSt :scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSe :scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CSf :scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>CSi :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" and split vertically
nnoremap <leader>CVs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVe :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>CVf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>CVi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

" clang setup
"inoremap <C-@> <C-X><C-U>
"let g:clang_complete_auto=0		" use autocompletion?
"let g:clang_auto_select=0		" select any from popup menu?
"let g:clang_hl_errors=1		" highlight errors like clang?
"let g:clang_complete_copen=0		" show quickfixes on error?
"let g:clang_periodic_quickfix=0	" autoupdate quickfix window?
"let g:clang_close_preview=1		" remove preview after completion?
"let g:clang_complete_macros=1		" complete preproc/macros?
" jump to declaration:	<C-]>
"  ~ in preview win:	<C-w>-]
" jump back:		<C-t> or <C-o>
"
vnoremap <silent> <leader>Cf    ! indent -kr -i8 -l100<CR>

nnoremap <leader>?q :echo "qc - show quickfix window\nqn / qp - navigate qf entries\nql - show location window\nqN / qP - navigate loc entries"<CR>
					" quickfix window stuff
nnoremap <leader>qc :cwindow<CR>
nnoremap <leader>qn :cn<CR>
nnoremap <leader>qp :cp<CR>
					" location window stuff
nnoremap <leader>ql :lwindow<CR>
nnoremap <leader>qN :lne<CR>
nnoremap <leader>qP :lp<CR>

" python tools
nnoremap <leader>?L :echo "Lp - lint python code"<CR>

" linter macros
nnoremap <silent> <leader>Lp    :lexpr system("pyflakes3 " . expand('%') . " ; pylint " . expand('%'))<CR>

" ===========================================================================
" Host-Specific Local Setup
" ===========================================================================
let local_rc_files = split(globpath("~/.vim/local/", "*.vimrc"), '\n')
for local_rc in local_rc_files
	execute('source '.local_rc)
endfor

" ===========================================================================
" Finalization
" ===========================================================================
set noexrc				" don't use $PWD/.vimrc files
set secure				" restrict vimrc files in $PWD
