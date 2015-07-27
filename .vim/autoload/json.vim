" Format current buffer with json_pp
function! json#DoPrettyJSON()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  silent %!json_pp -
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction

