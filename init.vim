" basic options
set number relativenumber hlsearch
set hidden confirm autochdir 
syntax on

" executes the current line as vimscript
nnoremap <leader>x :exe getline(".")<return>

" blasphemy
nnoremap <C-s> :w<return>
inoremap <C-s> <esc>:w<return>a
fu SmartExit()
    if len(@%) " check if empty buffer
        wq
    else
        q
    endif
endfu
nnoremap <C-x> :call SmartExit()<return>
inoremap <C-x> :call SmartExit()<return>

" sorcery that makes C indentation not awful
set cindent
set cino=:0,(0,W4,l1

" did you know that Windows Notepad has this exact keybind? Now you do.
nnoremap <F5> :r !date --iso<return>

" indent current lines or selected lines, Emacs style
nnoremap <C-i> i<C-f><esc>
inoremap <C-i> <C-f>
vnoremap <C-i> :norm i<return>

" change in asterisks
nnoremap ci* F*lct*

" search for selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" clear search
nnoremap <leader>c :noh<return>
nnoremap <C-l> :noh<return>

" remember folds and position in file
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

if has('nvim') " (neovim only)

    " my based plugins
    call plug#begin()
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'tomasiser/vim-code-dark'
    Plug 'preservim/nerdtree'
    Plug 'mhinz/vim-startify'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-fugitive'
    call plug#end()

    let g:VM_maps = {}
    let g:VM_maps["Add Cursor Down"] = "<A-j>"
    let g:VM_maps["Add Cursor Up"] = "<A-k>"

	inoremap <silent> <C-n> <C-R>=coc#start()<CR>

    " replicate vanilla vim terminal behaviour
    tnoremap <C-w> <C-\><C-n><C-w>
    tnoremap <C-w>N <C-\><C-n>

    " no line numbers in terminal
    aug term
        autocmd!
        autocmd TermOpen * set nonumber norelativenumber
    aug END

    " vim has these but they don't work I guess
    set termguicolors cursorline

    colo codedark

else " (vanilla vim only)

    " tfw no ftplugin
    set      ts=4 sw=4 et
    setlocal ts=4 sw=4 et " this still doesn't work(???) but I'm keeping it in out of spite

    " this bind lives here because neovim includes it already :)
    nnoremap gd viwy/\V<C-R>=escape(@",'/\')<CR><CR>

end

" my comfy modified desert
" this lives down here because it has to... for some reason
" I don't use this but I spent time on it so here it is
fu DesertTheme()
    colo desert
    hi Normal                     guibg=NONE
    hi LineNr       guifg=gray    guibg=#111111 ctermfg=gray   ctermbg=black
    hi CursorLineNr guifg=yellow  guibg=#111111 ctermfg=yellow ctermbg=black
    hi CursorLine                 guibg=#111111
    hi VertSplit    guifg=#c2bfa5 guibg=#c2bfa5 ctermfg=gray   ctermbg=gray
endfu
"call DesertTheme()
