" Format current buffer with xmllint
function! xml#DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  silent %!xmllint --format -
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction

