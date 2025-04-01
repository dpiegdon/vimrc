" Vim color file
" 2010-03-16 losTrace.

hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "losTrace"

" GUI
highlight Normal     guifg=White        guibg=Black
highlight Search     guifg=Black        guibg=Yellow    gui=bold
highlight Visual                                        gui=reverse
highlight Cursor     guifg=Black        guibg=Yellow    gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=DodgerBlue3
highlight StatusLine guifg=blue         guibg=white
highlight Statement  guifg=Yellow                       gui=NONE
highlight Type                                          gui=NONE
highlight SpecialKey                                                    term=bold ctermbg=0 ctermfg=3
"highlight NonText                                                      term=bold ctermbg=4 ctermfg=0
highlight Folded     guifg=magenta      guibg=black                     term=standout cterm=NONE ctermfg=darkmagenta    ctermbg=black
highlight FoldColumn guifg=cyan         guibg=black                     term=standout cterm=NONE ctermfg=cyan           ctermbg=black

highlight Constant   guifg=red          guibg=black                     term=underline ctermfg=1
highlight Number     guifg=red          guibg=black                     term=underline ctermfg=1

highlight ColorColumn  ctermbg=darkblue

