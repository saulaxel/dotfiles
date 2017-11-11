" ConfiguraciOn general {
    " ConfiguraciOn vim
    set nocompatible
    scriptencoding utf-8
    filetype off

    " ConfiguraciOn texto
    set number
    set relativenumber " NumeraciOn de lIneas desde tu posiciOn actual
    set linebreak
    set showbreak=...\              " Se muestran 3 puntos para simbolizar continuaciOn
    if has("patch-7.4.354") || has('nvim')
        set breakindent
    endif
    set textwidth=100
    set showmatch
    set visualbell
    set ruler

    " ConfiguraciOn para la busqueda
    set hlsearch
    set smartcase
    set ignorecase
    set incsearch

    " Ex menU
    "set path+=**       " BUsqueda recursiva de archivos
    set wildmenu

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

    " Guias visuales, se resalta la lInea y columna actuales y la columna 80
    set cursorline
    set cursorcolumn
    set colorcolumn=80

    " Extras
    set autowrite
    set spelllang=es
    set spell
    set undolevels=1000
    set backspace=indent,eol,start
    set splitright
    set splitbelow
    if has('conceal')
        set conceallevel=2 concealcursor=niv
    endif
" }

" Plugins y sus configuraciones {
    " Fijar la ruta en tiempo de ejecuciOn para incluir Vundle e inicializarlo
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Permitir que Vundle administre Vundle (requerido)
    Plugin 'VundleVim/Vundle.vim'

    " Completado de cOdigo
    if has('nvim')                          " Ventana de auto-completado
        Plugin 'Shougo/deoplete.nvim'
    else
        if has(v:version >= 800) && has("python3")
            Plugin 'Shougo/deoplete.nvim'
            Plugin 'roxma/nvim-yard'
            Plugin 'roxma/vim-hug-neovim-rpc'
        elseif has('lua')
            Plugin 'Shougo/neocomplete'
        endif
    endif

    Plugin 'Shougo/neosnippet'              " Gestor de plantillas
    Plugin 'Shougo/neosnippet-snippets'     " Plantillas de fabrica
    Plugin 'Shougo/neoinclude.vim'          " Completado de archivos
    Plugin 'Shougo/neco-vim'                " Completado de vimscript
    Plugin 'mattn/emmet-vim'                " Completado de html/css
    Plugin 'Shougo/vimproc.vim'             " Requerimiento del que sigue
    Plugin 'osyo-manga/vim-marching'        " Completado c/cpp
    Plugin 'artur-shaik/vim-javacomplete2'  " Completado de java
    Plugin 'davidhalter/jedi-vim'           " Completado de python

    if has('nvim') || (v:version >= 800)    " RevisiOn de errores
        Plugin 'w0rp/ale'
    else
        Plugin 'Syntastic'
    endif

    " Mejoras en la ediciOn y movimiento
    Plugin 'scrooloose/nerdtree.git'        " Arbol de directorios
    Plugin 'majutsushi/tagbar'              " Arbol de tags
    Plugin 'kshenoy/vim-signature'          " Marcas sobre lIneas
    Plugin 'matchit.zip'                    " Moverse entre etiquetas html
    Plugin 'PeterRincker/vim-argumentative' " Objeto de texto 'argumento'
    Plugin 'vim-indent-object'              " Objeto de texto 'indentado'
    Plugin 'kana/vim-textobj-user'          " Definir objetos de texto
    Plugin 'kana/vim-textobj-line'          " Objeto de texto 'lInea'
    Plugin 'kana/vim-textobj-function'      " Objeto de texto 'funciOn'
    Plugin 'glts/vim-textobj-comment'       " Objeto de texto 'comentario'
    Plugin 'zandrmartin/vim-textobj-blanklines' " Bloques en blanco
    Plugin 'jiangmiao/auto-pairs'           " Completar pares de sImbolos
    Plugin 'tpope/vim-surround'             " Encerrar / liberar secciones
    Plugin 'The-NERD-Commenter'             " Comentar / des-comentar
    Plugin 'tpope/vim-commentary'           " Comentar / des-comentar
    Plugin 'ReplaceWithRegister'            " Manejo de registros
    Plugin 'tpope/vim-repeat'               " Repetir plugins con .
    Plugin 'christoomey/vim-system-copy'    " Copiar a la papelera del sistema
    Plugin 'Tabular'                        " Alinear cOdigo
    Plugin 'junegunn/vim-easy-align'        " ''' '''
    Plugin 'KabbAmine/vCoolor.vim'          " InserciOn de valores RGB

    " Estilo visual y reconocimiento de sintaxis
    Plugin 'Solarized'                      " Tema de color
    Plugin 'rafi/awesome-vim-colorschemes'  " MAs temas de color
    Plugin 'vim-airline/vim-airline'        " Barra inferior
    Plugin 'vim-airline/vim-airline-themes' " Temas de color para barra
    Plugin 'gregsexton/MatchTag'            " Iluminar etiqueta hermana
    Plugin 'ap/vim-css-color'               " Colorear valores RGB
    "Plugin 'Rykka/colorv.vim'
    "Plugin 'mattn/webapi-vim'
    Plugin 'sheerun/vim-polyglot'           " Sintaxis de varios lenguajes
    Plugin 'Beerstorm/vim-brainfuck'        " Sintaxis de brainfuck

    " Otros plugins interesantes
    "Plugin 'https://github.com/shinokada/SWTC.vim.git'
    "Plugin 'sokoban.vim'
    "Plugin 'johngrib/vim-game-code-break'

    " Todos los plugins deben ir antes de la siguiente lInea
    call vundle#end()
    filetype plugin indent on

    " ConfiguraciOn de neocomplete-deoplete
    if has('nvim') || (has(v:version >= 800) && has("python3"))
        let g:deoplete#enable_at_startup = 1
    else
        let g:neocomplete#enable_at_startup = 1
    endif

    imap <C-e> <Plug>(neosnippet_expand_or_jump)
    smap <C-e> <Plug>(neosnippet_expand_or_jump)
    xmap <C-e> <Plug>(neosnippet_expand_target)

    inoremap <expr><C-g> neocomplete#undo_completion()

    " ConfiguraciOn de neosnippet
    let g:neosnippet#enable_snipmate_compatibility = 1

    "" ConfiguraciOnde vim-marching
    let g:marching#clang_command#options = {
    \       "c"   : "-std=gnu11",
    \       "cpp" : "-std=gnu++14"
    \   }

    let g:marching_enable_neocomplete = 1

    set updatetime=50

    imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
    imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

    " ConfiguraciOn de jedi
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0

    " ConfiguraciOn de easy-align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " ConfiguraciOn de ale / Syntastic
    if has('nvim')
        let g:ale_set_quickfix = 1
        let g:ale_cpp_clangcheck_options = "-extra-arg='-std=c++14'"
    else
        let g:syntastic_cpp_compiler_options = '-std=c++14'
    endif

    " ConfiguraciOn de AutoPairs (carActeres de apertura y cierre)
    let g:AutoPairs = {
                \ '(' : ')',
                \ '[' : ']',
                \ '{' : '}',
                \ '"' : '"',
                \ "'" : "'",
                \ '¿' : '?',
                \ '¡' : '!'
                \}

    " ConfiguraciOn de airline (La barra de informaciOn de abajo)
    set laststatus=2
    let g:airline_theme='angr'
    let g:airline#extensions#tabline#enabled = 1

    if 1 < 0
        let g:airline_powerline_fonts = 1
    else
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif

        let g:airline_powerline_fonts = 0
        let g:airline_left_sep='▶'
        let g:airline_right_sep='◀'
        let g:airline_symbols.crypt = '🔒'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.readonly = ''
    endif

" }

" Funciones {
    function! VerMarcas()
        syntax enable
    endfunction

    function! DoblarFunciones()
        set foldmethod=syntax
        set foldnestmax=1
    endfunction

    function! ModoDificil()
        inoremap <Esc>   <NOp>

        inoremap <Up>    <NOp>
        inoremap <Down>  <NOp>
        inoremap <Left>  <NOp>
        inoremap <Right> <NOp>

        nnoremap <Up>    <NOp>
        nnoremap <Down>  <NOp>
        nnoremap <Left>  <NOp>
        nnoremap <Right> <NOp>

        nnoremap h       <NOp>
        nnoremap j       <NOp>
        nnoremap k       <NOp>
        nnoremap l       <NOp>

        set norelativenumber
    endfunction

    function! ModoWeb()
        set nolist
        imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
        smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
        xmap <expr><Tab> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

        imap <Up>    <C-p>
        imap <Down>  <C-n>
    endfunction

    function! Ejecutar()
        if len(getqflist()) == 0        " Run the program
            if (&filetype == 'c' || &filetype == 'cpp')
                !./%:t:r
            elseif (&filetype == 'java')
                !java %:t:r
            elseif (&filetype == 'python')
                !python3 %
            elseif (&filetype == 'sh')
                !bash %
            endif
        else
            copen
        endif
    endfunction
" }

" Comandos automAticos {
    " Definiendo el gestor de autocompletado de cada tipo
    augroup omnifunctions
        autocmd!
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType python setlocal omnifunc=jedi#completions
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType java setlocal omnifunc=javacomplete#Complete
    augroup END
    " Definiendo el make
    augroup makecomnads
        autocmd!
        autocmd Filetype c          setlocal makeprg=gcc\ %\ -std=c11\ -o\ %:t:r\ -Wall\ -Wextra
        autocmd Filetype cpp        setlocal makeprg=g++\ %\ -std=c++14\ -o\ %:t:r\ -Wall\ -Wextra
        autocmd Filetype java       setlocal makeprg=javac\ %
        autocmd Filetype html       setlocal makeprg=xdg-open\ %
        autocmd Filetype python     setlocal makeprg=flake8\ %
        autocmd Filetype cs         setlocal makeprg=mcs\ %
        autocmd Filetype sh         setlocal makeprg=bash\ -n\ %
    augroup END

    " Definiendo configuraciOnes especificas para cada tipo de archivos
    augroup fileconfig
        autocmd!
        autocmd BufEnter *.nasm setlocal filetype=nasm
        autocmd BufEnter *.jade setlocal filetype=pug
        autocmd BufEnter *.h setlocal filetype=c
        autocmd Filetype html,xml,jade,pug,htmldjango,css,scss,sass,php imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
        autocmd Filetype html,css,scss,sass,pug,php setlocal ts=2 sw=2 sts=2
    augroup END
" }

" Mapeos {

    " Mapeos bAsicos
    let mapleader = "\,"
    nnoremap Q <nop>
    inoremap kj <Esc>
    nnoremap <C-k> -l
    nnoremap <C-j> +l
    nnoremap <space> za
    nnoremap Y y$
    nnoremap <leader>cbox :Tabularize /*<cr>vip<Esc>:substitute/ /=/g<cr>r A/<Esc>vipo<Esc>0r/:substitute/ /=/g<cr>:nohlsearch<cr>
    nnoremap <leader>r :%s/\<<C-r>=expand("<cword>")<CR>\>\C//g<Left><Left>
    nnoremap <leader>R :%s/\<<C-r>=expand("<cWORD>")<CR>\>\C//g<Left><Left>
    inoremap <leader>pk <Esc>:VCoolor<Return>a
    inoremap <leader>scp <Esc>:!gpick<Return>a

    " Para modificar fácilmente este archivo
    nnoremap <leader>av :tabnew $MYVIMRC<CR>
    nnoremap <leader>sv :source $MYVIMRC<CR>

    " Abreviaciones
    iabbrev fro for
    iabbrev lenght length
    iabbrev widht  width
    iabbrev heigth height
    iabbrev prt    ptr
    iabbrev tis    this
    iabbrev tihs   this
    iabbrev form   from

    " Manejo de ventanas
    nnoremap \| :vsplit<space>
    nnoremap _ :split<space>

    " Manejo de tabulaciones
    nnoremap <leader>tn :tabnew<Space>

    nnoremap <leader>tk :tabnext<CR>
    nnoremap <leader>tj :tabprev<CR>
    nnoremap <leader>th :tabfirst<CR>
    nnoremap <leader>tl :tablast<CR>

    " Mapeos del modo comando {
        " Movimiento estilo emacs
        cnoremap <C-a> <Home>
        cnoremap <C-b> <Left>
        cnoremap <C-f> <Right>
        cnoremap <C-d> <Delete>
        cnoremap <M-b> <S-left>
        cnoremap <M-f> <S-right>
        cnoremap <M-d> <S-right><C-w>

        " Escribir archivos que requieren sudo
        cnoremap w!! w !sudo tee % >/dev/null
        " Evitar el uso errOneo de mayUsculas
        " al intentar salir o guardar un archivo
        cnoremap Q q
        cnoremap W w
        cnoremap WW W
        cnoremap QQ Q
    " }

    " Mapeos de modo terminal neovim
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
        tmap     kj    <Esc>
    endif

    " Abrir fAcilmente el Arbol de directorios y de etiquetas
    map <F5> :NERDTreeToggle<Return>
    map <F6> :TagbarToggle<Return>

    " CorrecciOn de errores en el mismo archivo
    map <F9> :make<Return>:call Ejecutar()<Return>
"" }

" Tema de color {
    " ConfiguraciOn de la paleta de colores
    syntax enable
    "set background=dark
    set t_Co=256            " Usar terminal con 256 colores
    "let g:solarized_termcolors=16
    colorscheme tender
" }
