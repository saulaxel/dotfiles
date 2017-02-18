" ConfiguraciOn bAsica
set nocompatible
scriptencoding utf-8
filetype off

" Transformar la tecla Escape en Block Mayus y Block Mayus en Escape
"autocmd VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"autocmd VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x09 = Caps_Lock'
"autocmd VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
"autocmd VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x09 = Escape'

" ConfiguraciOn de la paleta de colores de solarized
syntax enable
if has('gui_running')
    set background=light
else
    set background=dark
endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
" Fin de la configuraciOn de la paleta de colores

" resaltado de la lInea actual
highlight CursorLine ctermbg=black
set cursorline
highlight CursorColumn ctermbg=black
set cursorcolumn

" Resaltado de la columna no 80 para usarla como guia
highlight ColorColumn ctermbg=black
set colorcolumn=80

" Fijar la ruta en tiempo de ejecuciOn para incluir Vundle e inicializarlo
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Permitir que Vundle administre Vundle (requerido)
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree.git'
Plugin 'Syntastic'
"Plugin 'AutoComplPop'
Plugin 'mattn/emmet-vim'
Plugin 'matchit.zip'
Plugin 'Solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'The-NERD-Commenter'
Plugin 'jade.vim'
Plugin 'ap/vim-css-color'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'Tabular'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'https://github.com/gregsexton/MatchTag.git'
"Plugin 'https://github.com/Valloric/MatchTagAlways.git'


Plugin 'https://github.com/shinokada/SWTC.vim.git'

" Todos los plugins deben ir antes de la siguiente lInea
call vundle#end()
filetype plugin indent on

" ConfiguraciOn de airline (La barra de informaciOn de abajo)
set laststatus=2
let g:airline#extensions#tabline#enable = 1
let g:airline_powerline_fonts = 1

" ConfiguraciOn de neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_lenght = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'.gosh_completions'
    \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g> neocomplete#undo_completion()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippet_directory='~/.vim/bundle/vim-snippets/snippets'

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" ConfiguraciOn del texto plano
set number
set linebreak
set showbreak=...\ 
set textwidth=100
set showmatch
set visualbell
set ruler

" NumeraciOn de lIneas desde tu posiciOn actual
set relativenumber
 
" ConfiguraciOn para la busqueda
set hlsearch
set smartcase
set ignorecase
set incsearch
set nohidden
 
" ConfiguraciOn para el indentado automAtico
set autoindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" RepresentaciOn de los carActeres invisibles
set list
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮

" Extras 
set undolevels=1000
set backspace=indent,eol,start 
set splitright
set splitbelow

" Definiendo el make
autocmd Filetype c set makeprg=gcc\ %
autocmd Filetype java set makeprg=javac\ %
autocmd Filetype html set makeprg=xdg-open\ %
autocmd Filetype python set makeprg=python\ %

" Definiendo configuraciOnes especificas para cada tipo de archivos
autocmd BufEnter *.jade set filetype=jade
autocmd Filetype html NoMatchParen
autocmd Filetype html,jade,pug,htmldjango,css,scss,sass,php imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>") 
autocmd Filetype html,*.jade,python,php set ts=2 sw=2 sts=2

"" ##### Mapeo de algunas funciones Utiles #####

" ConfiguraciOn rApida
let mapleader = "\,"
nnoremap <leader>av :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" AgilizaciOn del trabajo
inoremap kj <Esc>
nnoremap <C-k> -l
nnoremap <C-j> +l
nnoremap <space> za
nnoremap Y y$
noremap .tab <Esc>:Tabularize /*<cr>{jr/:s/ /=/g<cr>}a/<esc>:s/ /=/g<cr>:nohlsearch<cr>r 
inoremap <leader>pk <Esc>:VCoolor<Return>a
inoremap <leader>scp <Esc>:!gpick<Return>a

" Manejo de tabulaciones
nnoremap <leader>tn :tabnew<Space>

nnoremap <leader>tk :tabnext<CR>
nnoremap <leader>tj :tabprev<CR>
nnoremap <leader>th :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>

" Mapeos del modo comando
" Escribir archivos que requieren sudo
cnoremap w!! w !sudo tee % >/dev/null
" Evitar el uso erroneo de mayusculas
" al intentar salIr o guardar un archivo
cnoremap Q q
cnoremap W w

" Teclas para activar y desactivar numeraciOn relativa
map <F5> :set relativenumber!<Return>

" Debug en lenguajes compilados
map <F7> :cprevious<Return>
map <F8> :cnext<Return>
map <F9> :make<Return>:copen<Return>

" Arbol de directorios
map <F12> :NERDTree<Return>

" Gato
"echom "(>^.^<)"

" Modo dificil
"inoremap <Esc> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>

