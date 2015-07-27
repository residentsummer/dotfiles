" openssl.vim version 3.2 2008 Noah Spurrier <noah@noah.org>
"
" == Edit OpenSSL encrypted files and turn Vim into a Password Safe! ==
"
" This plugin enables reading and writing of files encrypted using OpenSSL.
" The file must have the extension of one of the ciphers used by OpenSSL. For
" example:
"
"    .des3 .aes .bf .bfa .idea .cast .rc2 .rc4 .rc5 (.bfa is base64 ASCII
"    encoded blowfish.)
"
" This will turn off the swap file and the .viminfo log. The `openssl` command
" line tool must be in the path.
"
" == Install ==
"
" Put this in your plugin directory and Vim will automatically load it:
"
"    ~/.vim/plugin/openssl.vim
"
" You can start by editing an empty unencrypted file. Give it one of the
" extensions above. When you write the file you will be asked to give it a new
" password.
"
" This plugin can also make a backup of an encrypted file before writing
" changes. This helps guard against the situation where you may edit a file
" and write changes with the wrong password. You can still go back to the
" previous backup version. The backup file will have the same name as the
" original file with .bak before the original extension. For example:
"
"     .auth.bfa  -->  .auth.bak.bfa
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

augroup openssl_encrypted
if exists("openssl_encrypted_loaded")
    finish
endif
let openssl_encrypted_loaded = 1
autocmd!

function! s:PrepareCipherOptions(ext)
    let l:result = ""

    if a:ext == "aes"
        let l:result = "-aes-256-cbc"
    elseif a:ext == "desa"
        let l:result = "-des-ede3-cbc -a"
    elseif a:ext == "bfa"
        let l:result = "-bf -a"
    else
        let l:result = "-" . a:ext
    endif

    return l:result
endfunction

function! s:OpenSSLReadPre()
    setlocal cmdheight=3
    setlocal viminfo=
    setlocal noswapfile noundofile nobackup
    setlocal shell=/bin/sh
    setlocal bin
endfunction

function! s:OpenSSLReadPost()
    let l:cipher_opt = s:PrepareCipherOptions(expand("<afile>:e"))
    let l:expr = "0,$!openssl enc " . l:cipher_opt . " -d -salt"

    execute l:expr
    if v:shell_error
        silent! 0,$y
        silent! undo
        echo "COULD NOT DECRYPT USING EXPRESSION: " . expr
        echo "Note that your version of openssl may not have the given cipher engine built-in"
        echo "even though the engine may be documented in the openssl man pages."
        echo "ERROR FROM OPENSSL:"
        echo @"
        echo "COULD NOT DECRYPT"
        return
    endif
    setlocal nobin
    setlocal cmdheight&
    setlocal shell&
    execute ":doautocmd BufReadPost " . expand("<afile>:r")
    redraw!
endfunction

function! s:OpenSSLWritePre()
    setlocal cmdheight=3
    setlocal shell=/bin/sh
    setlocal bin

    if !exists("g:openssl_backup")
        let g:openssl_backup=0
    endif
    if (g:openssl_backup)
        silent! execute '!cp % %:r.bak.%:e'
    endif

    let l:cipher_opt = s:PrepareCipherOptions(expand("<afile>:e"))
    let l:expr = "%!openssl enc " . l:cipher_opt . " -e -salt"

    silent! execute l:expr
    if v:shell_error
        silent! 0,$y
        silent! undo
        echo "COULD NOT ENCRYPT USING EXPRESSION: " . expr
        echo "Note that your version of openssl may not have the given cipher engine built in"
        echo "even though the engine may be documented in the openssl man pages."
        echo "ERROR FROM OPENSSL:"
        echo @"
        echo "COULD NOT ENCRYPT"
        return
    endif
endfunction

function! s:OpenSSLWritePost()
    silent! undo
    setlocal nobin
    setlocal shell&
    setlocal cmdheight&
    redraw!
endfunction

autocmd BufReadPre,FileReadPre     *.des3,*.des,*.bf,*.bfa,*.aes,*.idea,*.cast,*.rc2,*.rc4,*.rc5,*.desx,*.desa call s:OpenSSLReadPre()
autocmd BufReadPost,FileReadPost   *.des3,*.des,*.bf,*.bfa,*.aes,*.idea,*.cast,*.rc2,*.rc4,*.rc5,*.desx,*.desa call s:OpenSSLReadPost()
autocmd BufWritePre,FileWritePre   *.des3,*.des,*.bf,*.bfa,*.aes,*.idea,*.cast,*.rc2,*.rc4,*.rc5,*.desx,*.desa call s:OpenSSLWritePre()
autocmd BufWritePost,FileWritePost *.des3,*.des,*.bf,*.bfa,*.aes,*.idea,*.cast,*.rc2,*.rc4,*.rc5,*.desx,*.desa call s:OpenSSLWritePost()

augroup END

