" ConfiguraciOn bAsica (y necesaria)
set nocompatible
filetype off

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
Plugin 'AutoComplPop'
Plugin 'mattn/emmet-vim'
Plugin 'matchit.zip'
Plugin 'Solarized'
Plugin 'AutoClose'
Plugin 'The-NERD-Commenter'
Plugin 'jade.vim'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'Tabular'
Plugin 'vim-airline/vim-airline'

Plugin 'https://github.com/shinokada/SWTC.vim.git'

" Todos los plugins deben ir antes de la siguiente lInea
call vundle#end()
filetype plugin indent on

" ConfiguraciOn de airline
set laststatus=2
let g:airline#extensions#tabline#enable = 1
let g:airline_powerline_fonts = 1

" ConfiguraciOn del texto plano
set number
set linebreak
set showbreak=+++
set textwidth=100
set showmatch
set visualbell

" Hacer apareces una regla para numerar lIneas y que cuente desde tu posiciOn
set ruler
set relativenumber
 
" ConfiguraciOn para la busqueda
set hlsearch
set smartcase
set ignorecase
set incsearch
 
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
inoremap <leader>pk <Esc>:VCoolor<Return>a
inoremap <leader>scp <Esc>:!gpick<Return>a
iabbrev FORI for(int i = 0; i < c; ++i) {<NewLine>}<Esc>kfch
autocmd Filetype c iabbrev pf printf("");<Esc>3h
autocmd Filetype c iabbrev sc scanf("",);<Esc>4h
autocmd Filetype java iabbrev pl System.out.println();<Esc>h1

" Manejo de tabulaciones
nnoremap tn :tabnew<Space>

nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" Teclas para activar y desactivar numeraciOn relativa
map <F5> :set relativenumber!<Return>
""map <F6> :set norelativenumber<Return>

" Debug en lenguajes compilados
map <F7> :cprevious<Return>
map <F8> :cnext<Return>
map <F9> :make<Return>:copen<Return>

" Arbol de directorios
map <F12> :NERDTree<Return>

" Gato
"echom "(>^.^<)"

" Modo dificil
inoremap <Esc> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
