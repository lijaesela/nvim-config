" this text editor is so cool that it can't change the font size
" this works with gvim and nvim-qt
" this file's comments were censored heavily

if has('nvim')
    let g:fontdelim = ":h"
    " this needs to be conditionally bound...?
    noremap <C--> :call Font(-1)<return>
else
    " my modified desert theme breaks in gvim, so I give up
    colo desert
    set guioptions -=m 
    set guioptions -=T 
    set guioptions -=r 
    set guioptions -=L 
    let g:fontdelim = " "
    noremap <C-_> :call Font(-1)<return>
end

noremap <C-=> :call Font(1)<return>

" my config layer atop Vim's awful one :)
let g:myfont = "FreeMono"
let g:myfontsize = 20

" changes font size by given number
fu Font(inc)
    let g:myfontsize = g:myfontsize + a:inc
    let &guifont = g:myfont . g:fontdelim . g:myfontsize
endfu

" set the font at startup
let &guifont = g:myfont . g:fontdelim . g:myfontsize
