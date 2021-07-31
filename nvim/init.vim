" basic options
set number relativenumber hlsearch
set hidden confirm autochdir 
set termguicolors cursorline
syntax on

" executes the current line as vimscript
nnoremap <leader>x :exe getline(".")<return>

" blasphemy
nnoremap <C-s> :w<return>
nnoremap <C-x> :q<return>

" sorcery that makes C indentation not awful
set cindent
set cino=:0,(0,W4,l1

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

" replicate vanilla vim terminal behaviour
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <C-w>N <C-\><C-n>

" no line numbers in terminal
aug term
    autocmd!
    autocmd TermOpen * set nonumber norelativenumber
aug END

" --- plugins and plugin options ---
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

colo codedark

" Soydev cursors
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = "<A-j>"
let g:VM_maps["Add Cursor Up"] = "<A-k>"

" simpler start screen
let g:startify_enable_special = 0
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

inoremap <silent> <C-n> <C-R>=coc#start()<CR>
