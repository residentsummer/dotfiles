"{{{  Preface

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim" || version < 700
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" disable all previously defined commands, useful for reloading vimrc
autocmd!
"}}}
"{{{  Bundles
" Enable Vundle
" P.S. messing with filetype is required
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Top plugins
Plugin 'bufkill.vim'
Plugin 'matchit.zip'
Plugin 'surround.vim'
Plugin 'guns/vim-sexp'
Plugin 'sjl/gundo.vim'
Plugin 'bufexplorer.zip'
Plugin 'Shougo/unite.vim'
Plugin 'kana/vim-fakeclip'
Plugin 'sickill/vim-pasta'
Plugin 'Shougo/vimproc.vim'
Plugin 'takac/vim-hardtime'
Plugin 'justinmk/vim-sneak'
Plugin 'mhinz/vim-startify'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'stefandtw/quickfix-reflector.vim'
Plugin 'Lokaltog/powerline', {'rtp':  'powerline/bindings/vim'}

" Master Pope's gems
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

" Filetypes
Plugin 'PKGBUILD'
Plugin 'elzr/vim-json'
Plugin 'jceb/vim-orgmode'
Plugin 'ekalinin/Dockerfile.vim'

" Colors
Plugin 'xoria256.vim'
Plugin 'junegunn/seoul256.vim'

" Less used ones
Plugin 'FSwitch'
Plugin 'ZoomWin'
Plugin 'StarRange'
Plugin 'view_diff'
Plugin 'The-NERD-tree'
Plugin 'majutsushi/tagbar'

" Kindergarden
Plugin 'davidhalter/jedi-vim'
" Snipmate with deps
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" 'Marks-Browser'
" 'OmniCppComplete'
" 'Tag-Signature-Balloons'
" 'The-NERD-Commenter'
" 'c.vim'
" 'STL-improved'
" 'javacomplete'
" 'openssl.vim'
" 'spiiph/vim-space'
" 'mileszs/ack.vim'
" 'bling/vim-airline'
" 'bling/vim-bufferline'
" 'scrooloose/syntastic'
" 'sjl/threesome.vim'
" 'nathanaelkane/vim-indent-guides'
" 'vim-scripts/DoxygenToolkit.vim'
" 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
" 'vim-scripts/Workspace-Manager'
" 'vim-scripts/gitdiff.vim'
" 'vim-scripts/imaps.vim'
" 'vim-scripts/sudo.vim'
" 'taglist.vim'

call vundle#end()
filetype plugin indent on
"}}}
"{{{  General options
"{{{  Backup and undo files
set nobackup          " don't keep backups
if !has("win32")
    " Preserve undo history across vim sessions
    set undofile undodir=~/.vim/undo//
endif
"}}}
"{{{  viminfo options
" '1000           Marks will be remembered for the last 1000 files you edited.
" <50             Contents of registers (up to 1000 lines each) will be remembered.
" s10             Registers with more than 100 Kbyte text are skipped.
" n~/vim/viminfo  The name of the file to use is "~/vim/viminfo".
" h               'hlsearch' highlighting will not be restored.
set viminfo='1000,<50,s10,h,n~/.vim/viminfo
"}}}
"{{{  Characters display and encodings
if has("multi_byte")
  set encoding=utf-8
  set fileencodings=ucs-bom,utf-8,cp1251
  setglobal fileencoding=utf-8
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  " Interpret this script as utf-8
  scriptencoding utf-8
endif

" Highlight trailing whitespace and other garbage
if has("multi_byte")
  " let is used due to unicode symbols not being properly read by windows
  let &listchars="trail:\uB7,tab:\uBB ,precedes:\u2039,extends:\u203A"
else
  set listchars=trail:\ ,tab:\ \ ,precedes:<,extends:>
endif
set list

set nowrap                        " don't wrap long lines
set display=lastline              " if last line is too long, display it anyway

set expandtab ts=4 sw=4 sts=4     " tab options
" set shiftround                  " indent with multiples of sw
set textwidth=100                 " Limit lines to 100 characters
"}}}
"{{{  Text navigation
set backspace=indent,eol,start    " allow backspacing over everything in insert mode
" set numberwidth=2 relativenumber  " show relative line numbers for jumps
set virtualedit=all               " stop cursor jumping
set scrolloff=10                  " scroll when cursor approaches top/bottom
set mouse=a                       " full mouse integration
set ruler                         " show the cursor position all the time
"}}}
"{{{  Commands tuning
set history=1000                  " keep 1000 lines of command line history
set showcmd                       " display incomplete commands
set shortmess+=aI
" Allow russian keyboard layout in normal mode
set langmap=йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ\;qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>
"}}}
"{{{  Search options
set incsearch                     " do incremental searching
set ignorecase                    " ignore case in search
set smartcase                     " and don't if there are capitals
set hlsearch                      " highlight search terms
set gdefault                      " replace is global by default
"}}}
"{{{  Files and buffers
set hidden                        " no need to save when changing buffers
set autoread                      " automatically reload unchanged buffers
set confirm                       " ask instead of failing
set sb spr                        " new window is put right of current, below current
set sessionoptions=curdir         " save only current directory

" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc
"}}}
"{{{  Status line
" set statusline=%<%f%h%m%r\ %b\ \ 0x\ \ %l,%c%V\ %P
set statusline=%{bufferline#generate_string()}
set laststatus=2                  " as recommended by powerline
"}}}
"{{{  Autocompletion
set wildmenu
set wildmode=longest:full,full    " see manual for detailed behavior
set wildchar=<Tab>
"}}}
"}}}
"{{{  Autocommands and plugins' options
"{{{  all
"{{{ init default augroup
augroup vimrc
    autocmd!
augroup END
"}}}
"{{{ open at last position
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd vimrc BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
"}}}
"}}}
"{{{  text
"set 'textwidth' to 78 characters for text files.
autocmd vimrc FileType text setlocal textwidth=78
"}}}
"{{{  json
let g:vim_json_syntax_conceal = 0
"}}}
"{{{  c/c++
"{{{  Omni completion settings
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 0
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" autocmd Filetype set completeopt=menuone,menu,longest
set complete=.,w,b,u,t,i,d
set completeopt=menu,longest
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"}}}
autocmd vimrc Filetype c,cpp set tags+=~/.vim/tags/cpp
"}}}
"{{{  binary
"{{{ Hexmode
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()
" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
"}}}
"{{{ autocommands
" vim -b : edit binary using xxd-format!
augroup binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
                \ if exists('b:editHex') && b:editHex |
                \     let b:editHex = 0 |
                \ endif

    " convert to hex on startup for binary files automatically
    " au BufReadPost *
    "             \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
                \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
                \   call setbufvar(expand("<afile>"), 'editHex', 0) |
                \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
                \ if exists("b:editHex") && b:editHex && &binary |
                \  let oldro=&ro | let &ro=0 |
                \  let oldma=&ma | let &ma=1 |
                \  silent exe "%!xxd -r" |
                \  let &ma=oldma | let &ro=oldro |
                \  unlet oldma | unlet oldro |
                \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
                \ if exists("b:editHex") && b:editHex && &binary |
                \  let oldro=&ro | let &ro=0 |
                \  let oldma=&ma | let &ma=1 |
                \  silent exe "%!xxd" |
                \  exe "set nomod" |
                \  let &ma=oldma | let &ro=oldro |
                \  unlet oldma | unlet oldro |
                \ endif
augroup END
"}}}
"}}}
"{{{  NERD *
  let NERDShutUp=1
  let NERDSpaceDelims=1
  let NERDTreeWinPos="left"
"}}}
"{{{  Bufexplorer
let g:bufExplorerDefaultHelp=1       " Do not show default help.
" let g:bufExplorerReverseSort=1       " Sort in reverse order.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=1        " Split right.
"}}}
"{{{ powerline
let g:Powerline_symbols = 'fancy'
"}}}
"{{{ airline
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1
"}}}
"{{{ bufferline
let g:bufferline_echo=0
let g:bufferline_rotate=1
"}}}
"{{{ tagbar
  let g:tagbar_sort=0 " Display tags in the order of appearance in file
  let g:tagbar_left=1
  let g:tagbar_width=30
  let g:tagbar_autoclose=0
  let g:tagbar_singleclick=1

  let g:tagbar_type_clojure = {
      \ 'ctagstype': 'clojure',
      \ 'kinds' : [
          \ 'n:namespace',
          \ 'd:definitions',
          \ 'f:functions',
          \ 'p:private functions',
          \ 'm:macro',
          \ 'r:routes',
          \ 'h:handlers',
          \ 'e:entities',
          \ 'i:inline',
          \ 'a:multimethod definition',
          \ 'b:multimethod instance',
          \ 'c:definition (once)',
          \ 's:struct',
          \ 'v:intern',
      \ ]
      \ }

  " Automatically opens tagbar
  " au vimrc FileType clojure,python nested :TagbarOpen
"}}}
"{{{ vim-clojure-static
" Add some style
" let g:clojure_special_indent_words += ",apply,defhandler"
let g:clojure_align_multiline_strings = 1
"}}}
"{{{ jedi-vim
" Jedi is changing completeopt otherwise
let g:jedi#auto_vim_configuration = 0
" Automatic completion only distracts me
let g:jedi#show_call_signatures = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
" Mappings
let g:jedi#goto_assignments_command = ""
let g:jedi#completions_command = "<C-N>"
let g:jedi#goto_command = "<C-]>"
"}}}
"{{{ gundo
" More space for diff window
let g:gundo_preview_bottom = 1
" Show history on the right
let g:gundo_right = 1
"}}}
"{{{ startify
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_bookmarks = [ '~/.vimrc' ]
let g:startify_change_to_vcs_root = 1
let g:startify_relative_path = 1
let g:startify_enable_special = 0
let g:startify_custom_indices = extend(['c'], map(range(1,100), 'string(v:val)'))
let g:startify_list_order = [
            \ [' Bookmarks:'],
            \ 'bookmarks',
            \ [' Sessions:'],
            \ 'sessions',
            \ [' LRU:'],
            \ 'files',
            \ [' LRU within this dir:'],
            \ 'dir',
            \ ]
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ $VIMRUNTIME .'/doc',
            \ 'bundle/.*/doc',
            \ '\.vimrc',
            \ ]
"}}}
"{{{ hardtime
let g:hardtime_default_on = 0
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
"}}}
"}}}
"{{{  Colorful life!
if has("gui_running")
    colorscheme xombat
    if has("gui_win32")
        set guifont=Consolas_for_Powerline_FixedD:h11:cRUSSIAN
    elseif has("gui_mac") || has("gui_macvim")
        " set guifont=Monaco\ for\ Powerline:h13
        " set guifont=Source\ Code\ Pro\ for\ Powerline:h13
        set guifont=Fira\ Mono:h13
    else
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 9
    endif
    " keys are starting and stopping selection
    "set keymodel=startsel,stopsel
    " always show tabs
    "set showtabline=2
    " maximize
    set lines=999 columns=999
    set guioptions=aic
    syntax on
    " It's double rainbow!!!
    au vimrc VimEnter * RainbowParenthesesToggle
    au vimrc Syntax * RainbowParenthesesLoadRound
    au vimrc Syntax * RainbowParenthesesLoadSquare
    au vimrc Syntax * RainbowParenthesesLoadBraces
elseif &t_Co > 2
  " vim hardcodes background color erase even if the terminfo file does
  " not contain bce (not to mention that libvte based terminals
  " incorrectly contain bce in their terminfo files). This causes
  " incorrect background rendering when using a color theme with a
  " background color.
  let &t_ut=''
  if &t_Co == 256
    colo xoria256
  else
    colo ron
  endif
  syntax on
  " Highlight long lines.
  "highlight rightMargin guibg=lightblue ctermbg=lightblue
  "match rightMargin /.\%>80v/
endif
"}}}
"{{{  Commands
"{{{  Diff between curr buffer and file it was loaded from
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
    command DiffOrig tabnew | buf # | vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
"}}}
"}}}
"{{{  Mappings
"{{{ Global
" let mapleader=","
let mapleader="\<Space>"
" Fuck the replace mode
imap <Ins> <Esc>a
" Don't use Ex mode, use Q for formatting
map Q gq
""}}}
"{{{ Copy-paste
" Make "Y" to behave like "C" and "D"
nmap Y y$
" Shortcuts for system clipboard
map <leader>y "+y
map <leader>Y "+Y
map <leader>p "+p
map <leader>P "+P
" Select just pasted region
nmap <leader>v V`]
""}}}
"{{{ Shift is slow
command Wq wq
command W w
command Qa qa
command Q q
"}}}
"{{{  Blocks indentation
vmap < <gv
vmap > >gv
"}}}
"{{{ Navigation
"{{{ Buffers
nmap <leader>k :bprevious<CR>
nmap <leader>j :bnext<CR>
nmap <leader><leader> <C-^>
"}}}
"{{{ Errors
nmap <C-p> :cp<CR>
nmap <C-n> :cn<CR>
"}}}
"{{{ Tags
nmap <C-PageUp> :tp<CR>
nmap <C-PageDown> :tn<CR>
"}}}
"{{{ Files
" nmap <leader>. :FSHere<CR>
"}}}
"{{{ Lines
" Emacs-like beginning and end of line.
imap <C-e> <C-o>$
imap <C-a> <C-o>^
"}}}
"{{{ Misc
" Match with tab - much easier to reach
nmap <Tab> %
"}}}
"}}}
"{{{ unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap ,. :Unite -no-split -start-insert file_rec/async<CR>
"}}}
"{{{ vim-commentary
nmap \ <plug>Commentary
nmap \\ <plug>CommentaryLine
vmap \\ <plug>Commentary
"}}}
"{{{ tagbar
map <leader>m :TagbarOpen jf<CR>
map <F11> :TagbarToggle<CR>
imap <F11> <C-O>:TagbarToggle<CR>
"}}}
"{{{ gundo
nmap <leader>u :GundoToggle<CR>
"}}}
"{{{ fugitive
command GcA Gcommit --amend --reuse-message=HEAD
nmap <leader>g :Gstatus<CR>
nmap <leader>gw :Gw<CR>
"}}}
"{{{ Quick save
nmap <leader>w :w<cr>
"}}}
"{{{ Search&replace
" Search keyword in all files from pwd
nnoremap ,/a :silent grep --exclude=.\*.swp -e "<cword>" -r .<CR>:cw<CR>
nnoremap ,//a :silent grep --exclude=.\*.swp -e "\<<cword>\>" -r .<CR>:cw<CR>
" Search keyword in all files of the same type (extension, to be precise)
nnoremap ,/  :silent grep --include=\*.<C-R>=expand('%:e')<CR> -e "\<<cword>\>" -r .<CR>:cw<CR>
nnoremap ,// :silent grep --include=\*.<C-R>=expand('%:e')<CR> -e "<cword>" -r .<CR>:cw<CR>
" no <leader>/ :silent grep -w -r <cword> --include=\*.\[hH\] --include=\*.\[cC\] --include=\*.cc --include=\*.cpp --include=\*.cxx .<CR>:cw<CR>
" Replace word under the cursor
nmap <F5> :%s/\<<C-R>=expand("<cword>")<cr>\>/
" Turn off search highlighting
nmap <F6> :nohl<CR>
imap <F6> <C-O>:nohl<CR>
"}}}
" "{{{ Misc
" Generate tag for completion in current dir
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" Insert a blank line before/after current
nmap go o<Esc>
nmap gO O<Esc>
" Split the line (opposite to J)
nnoremap H i<CR><Esc>k$:silent! call setline(".", substitute(getline("."), "\\s*$", "", ""))<CR>$
" Expand %% into the directory of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" Map j to gj and k to gk, so line navigation ignores line wrap
" ...but only if the count is undefined (otherwise, things like 4j
" break if wrapped LINES are present)
" nmap <expr> j (v:count == 0 ? 'gj' : 'j')
" nmap <expr> k (v:count == 0 ? 'gk' : 'k')
"}}}
"}}}
"{{{  Other
"{{{ Be calm
set noerrorbells vb t_vb=
"}}}
"{{{ Fix keys in screen
if &term == "screen"
  set t_kh=[H
  set t_@7=[F
  fixdel
endif
"}}}
"}}}

" vim: foldmethod=marker

