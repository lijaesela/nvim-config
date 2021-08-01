" this text editor is so cool that it can't change the font size
" this file's comments were censored heavily
" I personally use neovide, so this is tested with neovide

" my config layer atop Vim's awful one :)
let g:myfont = "Fira Code"
let g:myfontsize = 20
let g:fontdelim = ":h"

" changes font size by given number
fu Font(inc)
    let g:myfontsize = g:myfontsize + a:inc
    let &guifont = g:myfont . g:fontdelim . g:myfontsize
endfu

noremap <C--> :call Font(-1)<return>
noremap <C-=> :call Font(1)<return>

" set the font at startup
let &guifont = g:myfont . g:fontdelim . g:myfontsize
