" Vim color file
"
" Name:       xombat.vim
" Version:    0.1
" Maintainer: Anton Shkalev
"
" This colorscheme is a hybrid of wombat and xoria256.
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html



" Bla-bla ----------------------------------------------------------------------

if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
  echomsg ""
  finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "xombat"



" The real part ----------------------------------------------------------------

"" General colors
hi Normal       guifg=#f6f3e8 guibg=#242424 gui=none
hi CursorColumn               guibg=#2d2d2d
hi Cursor                     guibg=#656565 gui=none
hi CursorLine                 guibg=#2d2d2d
hi FoldColumn   guifg=#a8a8a8 guibg=bg
hi Folded       guifg=#a0a8b0 guibg=#384048 gui=none
hi IncSearch    guifg=#000000 guibg=#ffdfaf gui=none
hi NonText      guifg=#f6f3e8 guibg=#242424 gui=none
hi Pmenu        guifg=#f6f3e8 guibg=#444444
hi PmenuSbar                  guibg=#767676
hi PmenuSel     guifg=#000000 guibg=#cae682
hi PmenuThumb                 guibg=#d0d0d0
hi Search       guifg=#000000 guibg=#afdf5f
hi SignColumn   guifg=#a8a8a8
hi SpecialKey   guifg=#ff2222 guibg=#242424 gui=none
"hi SpecialKey   guifg=#808080 guibg=#303030 gui=none
hi StatusLine   guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi Title        guifg=#f6f3e8               gui=bold
hi TabLine      guifg=fg      guibg=#666666 gui=underline
hi TabLineFill  guifg=fg      guibg=#666666 gui=underline
hi VertSplit    guifg=#444444 guibg=#444444 gui=none
hi Visual       guifg=#f6f3e8 guibg=#444444 gui=none
hi VIsualNOS    guifg=#005f87 guibg=#afdfff gui=none
hi WildMenu     guifg=#000000 guibg=#dfdf00 gui=bold

"" Syntax highlighting
hi Comment      guifg=#99968b               gui=italic
hi Constant     guifg=#e5786d               gui=none
hi Error        guifg=#ffffff guibg=#800000
hi ErrorMsg     guifg=#ffffff guibg=#800000
hi Function     guifg=#cae682               gui=none
hi Identifier   guifg=#cae682               gui=none
hi Ignore       guifg=#444444
hi Keyword      guifg=#8ac6f2               gui=none
hi LineNr       guifg=#857b6f guibg=#000000 gui=none
hi MatchParen   guifg=#f6f3e8 guibg=#857b6f gui=bold
hi Number       guifg=#e5786d               gui=none
hi PreProc      guifg=#e5786d               gui=none
hi Special      guifg=#e7f6da               gui=none
hi Statement    guifg=#8ac6f2               gui=none
hi String       guifg=#95e454               gui=italic
hi Todo         guifg=#8f8f8f               gui=italic
hi Type         guifg=#cae682               gui=none
hi Underlined   guifg=#00afff               gui=underline

"" Special
""" .diff
hi diffAdded    guifg=#afdf87
hi diffRemoved  guifg=#df8787
""" vimdiff
hi diffAdd      guifg=bg      guibg=#afdfaf
"hi diffDelete    guifg=bg      guibg=#dfdf87 gui=none
hi diffDelete   guifg=bg      guibg=#949494 gui=none
hi diffChange   guifg=bg      guibg=#dfafaf
hi diffText     guifg=bg      guibg=#df8787 gui=none
""" TagList plugin
"hi MyTagListTagName this type of highlighting is undefined
hi default link MyTagListComment  Comment
hi default link MyTagListFileName Title
hi default MyTagListTitle         guifg=#cae682 gui=bold
hi default link MyTagListTagScope String

