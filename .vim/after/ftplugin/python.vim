" Unfold on open
setlocal foldmethod=indent foldlevel=20

" Open python doc for word under cursor
let s:pydoc_search_url = "https://docs.python.org/2.7/search.html?check_keywords=yes&q="
command! -nargs=1 Pydoc exec "silent !open '".s:pydoc_search_url."<args>'"
nnoremap K :Pydoc <C-R>=expand("<cword>")<CR><CR>


