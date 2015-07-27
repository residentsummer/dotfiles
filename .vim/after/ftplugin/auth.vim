" openssl.vim version 3.2 2008 Noah Spurrier <noah@noah.org>
"
" == Simple Vim Password Safe ==
"
" If you edit any file named '*.auth' or '*.auth.bak' then this plugin
" will add folding features.
"
" This plugin will fold on wiki-style headlines in the following format:
"
"     == This is a headline ==
"
" Any notes under the headline will be inside the fold until the next headline
" is reached. The SPACE key will toggle a fold open and closed. The q key will
" quit Vim. Create the following example file named ~/test.auth:
"
"     == Colo server ==
"
"     username: maryjane password: esydpm
"
"     == Office server ==
"
"     username: peter password: 4m4z1ng
"
" To turn on backups put the following global definition in your .vimrc file:
"
"     let g:openssl_backup = 1
"
" Thanks to Tom Purl for the original des3 tip.
"
" I release all copyright claims. This code is in the public domain.
" Permission is granted to use, copy modify, distribute, and sell this
" software for any purpose. I make no guarantee about the suitability of this
" software for any purpose and I am not liable for any damages resulting from
" its use. Further, I am under no obligation to maintain or extend this
" software. It is provided on an 'as is' basis without any expressed or
" implied warranty.
"
" $Id: openssl.vim 189 2008-01-28 20:44:44Z root $

augroup ftplugin_auth
autocmd!

function! HeadlineDelimiterExpression(lnum)
    if a:lnum == 1
        return ">1"
    endif
    return (getline(a:lnum)=~"^\\s*==.*==\\s*$") ? ">1" : "="
endfunction

setlocal foldexpr=HeadlineDelimiterExpression(v:lnum)
setlocal foldcolumn=0 foldlevel=0 foldmethod=expr
setlocal foldtext=getline(v:foldstart)

highlight Folded ctermbg=red ctermfg=black

" set updatetime=300000
" autocmd CursorHold                 *.auth quit

augroup END

