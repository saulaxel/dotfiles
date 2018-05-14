" ConfiguraciOn general {{{
    scriptencoding utf-8
    filetype off

    " VisualizaciOn de elementos auxiliares
    set number
    set relativenumber
    set ruler             " Ver lInea y columna actual en la barra inferior
    set showcmd           " Visualizar comandos en la barra inferior

    set list              " Ver representaciOn de carActeres invisibles
    set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮

    set linebreak
    set showbreak=...\    " 3 puntos para simbolizar continuaciOn
    set breakindent
    set cursorline
    set cursorcolumn
    set colorcolumn=80

    " Texto y ediciOn
    set fileformat=unix
    set textwidth=100
    set showmatch
    set backspace=indent,eol,start

    set splitright
    set splitbelow

    " Busqueda
    set hlsearch
    set smartcase
    set ignorecase
    set incsearch
    set nrformats+=alpha

    " MenU de modo comando
    "set path+=**       " BUsqueda recursiva de archivos
    set wildmenu
    set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

    " Indentado automAtico
    set autoindent
    set smarttab
    set tabstop=4 softtabstop=4 shiftwidth=4
    set expandtab

    " Lenguaje
    set spell
    set spelllang=es

    " Extras
    set noswapfile
    set visualbell
    set autowrite
    set lazyredraw
    set path+=/usr/lib/gcc/x86_64-linux-gnu/5/include,/usr/include/x86_64-linux-gnu/,/usr/include/glib-2.0/,/usr/include/glib-2.0/glib,/usr/include/gtk-3.0,/usr/include/gtk-3.0/unix-print
    set concealcursor=
    set formatprg=~/.vim/clang_tidy_sangria_correcta.sh
    set undolevels=1000
" }}}

" Plugins y sus configuraciones {{{
    " Fijar la ruta en tiempo de ejecuciOn para incluir Vundle e inicializarlo
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Manejo de paquetes y repositorios
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'

    " Completado y revisiOn de cOdigo
    if has('nvim') || (v:version >= 800 && has('python3'))
        Plugin 'Shougo/deoplete.nvim'
        if !has('nvim')
            Plugin 'roxma/nvim-yarp'
            Plugin 'roxma/vim-hug-neovim-rpc'
        endif
        Plugin 'w0rp/ale'                   " RevisiOn de sintaxis
        Plugin 'carlitux/deoplete-ternjs'   " Completado de javascript
    else
        Plugin 'Shougo/neocomplete'
        Plugin 'Syntastic'                  " RevisiOn de sintaxis
        Plugin 'ternjs/tern_for_vim'        " Completado de javascript
    endif
    Plugin 'Shougo/neosnippet'              " Gestor de plantillas de cOdigo
    Plugin 'Shougo/neosnippet-snippets'     " Plantillas de fabrica
    Plugin 'Shougo/neoinclude.vim'          " Completado de cabeceras
    Plugin 'Shougo/neco-vim'                " Completado de vimscript
    Plugin 'mattn/emmet-vim'                " Completado de html/css
    Plugin 'Shougo/vimproc.vim'             " Requerimiento del que sigue
    Plugin 'osyo-manga/vim-marching'        " Completado C/cpp
    Plugin 'artur-shaik/vim-javacomplete2'  " Completado de java
    Plugin 'jcommenter.vim'                 " Hacer comentarios de java
    Plugin 'davidhalter/jedi-vim'           " Completado de python
    Plugin 'tkhren/vim-fake'                " Insertar texto de muestra

    " EdiciOn
    Plugin 'scrooloose/nerdtree.git'        " Arbol de directorios
    Plugin 'majutsushi/tagbar'              " Lista de etiquetas de navegaciOn
    Plugin 'kshenoy/vim-signature'          " Marcas visuales
    Plugin 'prendradjaja/vim-vertigo'       " Movimiento lIneas
    Plugin 'matchit.zip'                    " Moverse entre etiquetas html
    Plugin 'tpope/vim-repeat'               " Repetir plugins con .
    Plugin 'Tabular'                        " Funciones para alinear cOdigo

    Plugin 'PeterRincker/vim-argumentative' " Objeto de texto 'argumento'
    Plugin 'vim-indent-object'              " Objeto de texto 'indentado'
    Plugin 'kana/vim-textobj-user'          " Requerimiento de los proximos
    Plugin 'kana/vim-textobj-line'          " Objeto de texto 'lInea'
    Plugin 'kana/vim-textobj-function'      " Objeto de texto 'funciOn'
    Plugin 'glts/vim-textobj-comment'       " Objeto de texto 'comentario'
    Plugin 'kana/vim-textobj-entire'        " Objeto de texto 'documento entero'
    Plugin 'svermeulen/vim-next-object'     " Objeto de texto 'siguiente'
    Plugin 'jiangmiao/auto-pairs'           " Completar pares de sImbolos
    Plugin 'tpope/vim-surround'             " Encerrar/liberar secciones
    Plugin 'The-NERD-Commenter'             " Operador comentar/des-comentar
    Plugin 'tpope/vim-commentary'           " Comentar/des-comentar (no es operador)
    Plugin 'ReplaceWithRegister'            " Operador para manejo de registros
    Plugin 'KabbAmine/vCoolor.vim'          " InserciOn de valores RGB
    Plugin 'sedm0784/vim-you-autocorrect'   " Corrección de errores

    " Estilo visual y reconocimiento de sintaxis
    Plugin 'Solarized'                      " Tema de color 'Solarized'
    Plugin 'rafi/awesome-vim-colorschemes'  " MAs temas de color
    Plugin 'vim-airline/vim-airline'        " Tener una barra inferior cool
    Plugin 'vim-airline/vim-airline-themes' " Temas de color para el plugin anterior
    Plugin 'gregsexton/MatchTag'            " Iluminar etiqueta hermana (html)
    Plugin 'ryanoasis/vim-devicons'         " Iconos para los archivos
    Plugin 'ap/vim-css-color'               " Colorear valores RGB
    Plugin 'sheerun/vim-polyglot'           " Sintaxis de varios lenguajes
    Plugin 'boeckmann/vim-freepascal'       " Sintaxis de freepascal
    Plugin 'dag/vim-fish'                   " Sintaxis de fish
    Plugin 'Beerstorm/vim-brainfuck'        " Sintaxis de brainfuck
    Plugin 'khzaw/vim-conceal'              " <-+
    Plugin 'KeitaNakamura/tex-conceal.vim'  " <-+-Enmascaramiento de
    Plugin 'sethwoodworth/vim-cute-python'  " <-+-palabras clave con
    Plugin 'discoloda/c-conceal'            " <-+-sImbolos unicode
    Plugin 'dkinzer/vim-schemer'            " <-+-
    Plugin 'calebsmith/vim-lambdify'        " <-+

    " Todos los plugins deben ir antes de la siguiente lInea
    call vundle#end()
    filetype plugin indent on

    " ConfiguraciOn de neocomplete-deoplete
    if has('nvim') || ((v:version >= 800) && has('python3'))
        let g:deoplete#enable_at_startup = 1
    else
        let g:neocomplete#enable_at_startup = 1
    endif

    imap <C-e> <Plug>(neosnippet_expand_or_jump)
    smap <C-e> <Plug>(neosnippet_expand_or_jump)
    xmap <C-e> <Plug>(neosnippet_expand_target)

    " ConfiguraciOn de neosnippet
    let g:neosnippet#enable_snipmate_compatibility = 1

    "" ConfiguraciOnde vim-marching
    let g:marching#clang_command#options = {
    \       'c'   : '-std=gnu11',
    \       'cpp' : '-std=gnu++14'
    \   }

    let g:marching_enable_neocomplete = 1
    set updatetime=50

    imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
    imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

    " ConfiguraciOn de jedi
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#force_py_version = 3

    " ConfiguraciOn de jcommenter
    nnoremap <leader>jd :call JCommentWriter()<Return>

    " ConfiguraciOn de vim-fake
    let g:fake_bootstrap = 1

    " ConfiguraciOn de easy-align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " ConfiguraciOn de ale / Syntastic
    let g:opciones_para_C = '-std=gnu11 -Wall -Wextra -Wstrict-prototypes `pkg-config --cflags glib-2.0` -Wno-missing-field-initializers'
    let g:opciones_para_Cpp = '-std=c++14 -Wall -Wextra'

    if has('nvim') || (v:version >= 800)
        let g:ale_set_quickfix = 1
        let g:ale_cpp_clangcheck_options = "-extra-arg='" . g:opciones_para_Cpp
        let g:ale_cpp_gcc_options = g:opciones_para_Cpp
        let g:ale_cpp_clang_options = g:opciones_para_Cpp
        let g:ale_cpp_clangtidy_options = g:opciones_para_Cpp
        let g:ale_c_gcc_options = g:opciones_para_C
        let g:ale_c_clang_options = g:opciones_para_C
        let g:ale_c_clangtidy_options = g:opciones_para_C
        let g:ale_c_clangtidy_checks = ['*', '-readability-braces-around-statements',
                    \'-google-readability-braces-around-statements', '-llvm-header-guard']
        let g:ale_haskell_ghc_options = '-dynamic'
        let g:ale_fortran_gcc_options = '-Wall -Wextra'
    else
        let g:syntastic_cpp_compiler_options = g:opciones_para_Cpp
        let g:syntastic_c_compiler_options = g:opciones_para_C
        let g:syntastic_haskell_compiler_options = '-dynamic'
        let g:syntastic_fotran_compiler_options = '-Wall -Wextra'
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

    " ConfiguraciOn de vim-vertigo
    nnoremap <silent> <C-j> :<C-U>VertigoDown n<CR>
    vnoremap <silent> <C-j> :<C-U>VertigoDown v<CR>
    onoremap <silent> <C-j> :<C-U>VertigoDown o<CR>
    nnoremap <silent> <C-k> :<C-U>VertigoUp n<CR>
    vnoremap <silent> <C-k> :<C-U>VertigoUp v<CR>
    onoremap <silent> <C-k> :<C-U>VertigoUp o<CR>

    " ConfiguraciOn de airline
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

    " ConfiguraciOn de vim-devicons
    set guifont=DroidSansMono\ Nerd\ Font\ 11
" }}}

" Funciones {{{
    function! VerMarcas()
        syntax enable
    endfunction

    function! DoblarFunciones()
        set foldmethod=syntax
        set foldnestmax=1
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
        if len(getqflist()) ==# 0        " Run the program
            if ( &filetype ==# 'c' ||
                        \ &filetype ==# 'cpp' ||
                        \ &filetype ==# 'haskell' ||
                        \ &filetype ==# 'fortran')

                !./%:t:r
            elseif (&filetype ==# 'java')
                !java %:t:r
            elseif (&filetype ==# 'python')
                !python3 %
            elseif (&filetype ==# 'sh')
                !bash %
            endif
        else
            copen
            setlocal nospell
        endif
    endfunction
" }}}

" Comandos automAticos {{{
    " Definiendo el gestor de autocompletado de cada tipo
    augroup omnifunctions
        autocmd!
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType python setlocal omnifunc=jedi#completions
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType java setlocal omnifunc=javacomplete#Complete
    augroup end

    " Definiendo el make
    augroup makecomnads
        autocmd!
        autocmd Filetype c          setlocal makeprg=gcc\ `pkg-config\ --cflags\ gtk+-3.0`\ %\ -std=gnu11\ -o\ %:t:r\ -lm\ -pthread\ -lX11\ `pkg-config\ --libs\ gtk+-3.0`
        autocmd Filetype cpp        setlocal makeprg=g++\ %\ -std=c++14\ -o\ %:t:r\ -Wall\ -Wextra\ -lm
        autocmd Filetype fortran    setlocal makeprg=gfortran\ %\ -o\ %:t:r\ -Wall\ -Wextra
        autocmd Filetype java       setlocal makeprg=javac\ %
        autocmd Filetype html       setlocal makeprg=xdg-open\ %
        autocmd Filetype python     setlocal makeprg=flake8\ %
        autocmd Filetype cs         setlocal makeprg=mcs\ %
        autocmd Filetype sh         setlocal makeprg=bash\ -n\ %
        autocmd Filetype haskell    setlocal makeprg=ghc\ %\ -dynamic
    augroup end

    " Definiendo configuraciOnes especificas para cada tipo de archivos
    augroup fileconfig
        autocmd!
        autocmd BufEnter *.nasm setlocal filetype=nasm
        autocmd BufEnter *.jade setlocal filetype=pug
        autocmd BufEnter *.h    setlocal filetype=c
        autocmd Filetype html,xml,jade,pug,htmldjango,css,scss,sass,php imap <buffer> <expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")
        autocmd Filetype html,css,scss,sass,pug,php setlocal ts=2 sw=2 sts=2
        autocmd Filetype html,css,scss,sass,pug     setlocal iskeyword+=-
    augroup end
" }}}

" Mapeos {{{

    " Mapeos bAsicos
    let g:mapleader = ','
    nnoremap Q <NOp>
    inoremap kj <Esc>
    nnoremap Y y$
    nmap <leader>ff zfaf
    nnoremap <space> za
    nnoremap <leader>cbox :Tabularize /*<Return>vip<Esc>:substitute/ /=/g<Return>r A/<Esc>vipo<Esc>0r/:substitute/ /=/g<Return>:nohlsearch<Return>
    nnoremap <leader>r :%s/\<<C-r>=expand("<cword>")<Return>\>\C//g<Left><Left>
    nnoremap <leader>R :%s/\<<C-r>=expand("<cWORD>")<Return>\>\C//g<Left><Left>
    inoremap <leader>pk <Esc>:VCoolor<Return>a
    inoremap <leader>scp <Esc>:!gpick<Return>a

    " Para modificar este archivo y aplicar los cambios
    nnoremap <leader>av :tabnew $MYVIMRC<Return>
    nnoremap <leader>sv :source $MYVIMRC<Return>

    " Manejo de ventanas
    nnoremap \| :vsplit<space>
    nnoremap _ :split<space>

    " Manejo de buffers
    nnoremap <leader>bn :edit<Space>
    nnoremap <leader>bk :bnext<Return>
    nnoremap <leader>bj :bprevious<Return>
    nnoremap <leader>bh :bfirst<Return>
    nnoremap <leader>bl :blast<Return>
    nnoremap <leader>bd :bdelete<Return>

    " Manejo de tabulaciones
    nnoremap <leader>tn :tabnew<Space>
    nnoremap <leader>tk :tabnext<Return>
    nnoremap <leader>tj :tabprev<Return>
    nnoremap <leader>th :tabfirst<Return>
    nnoremap <leader>tl :tablast<Return>
    nnoremap <leader>td :quit<Return>

    " Abrir manuales desde el archivo
    augroup configuracion_comando_man
        autocmd!
        autocmd FileType cpp nnoremap <buffer> K yiw:sp<CR>:te<CR>Acppman <C-\><C-n>pA<CR>
    augroup end

    " Mapeos del modo comando {
        " Movimiento estilo emacs
        cnoremap <C-a> <Home>
        cnoremap <C-b> <Left>
        cnoremap <C-f> <Right>
        "cnoremap <C-d> <Delete>
        cnoremap <M-b> <S-left>
        cnoremap <M-f> <S-right>
        "cnoremap <M-d> <S-right><C-w>

        " Escribir archivos que requieren sudo
        cnoremap w!! w !sudo tee % >/dev/null

        " Evitar uso errOneo de mayUsculas al intentar salIr
        cnoremap Q q
        cnoremap W w
        cnoremap WW W
        cnoremap QQ Q
    " }

    " Mapeos de modo terminal neovim
    if has('nvim')
        nnoremap <leader>ot :5sp<CR>:te<CR><C-\><C-n>:setlocal nospell<CR>A
        tnoremap <Esc> <C-\><C-n>
        tmap     kj    <Esc>
    endif

    " Ayudas estilo IDE
    noremap <F5> :NERDTreeToggle<Return>
    noremap <F6> :TagbarToggle<Return>
    noremap <F9> :make<Return>:call Ejecutar()<Return>
" }

" }}}

" Tema de color {{{
    syntax enable
    set t_Co=256            " Usar terminal con 256 colores
    colorscheme tender
" }}}

"let g:ale_linters = {
            "\   'c': ['gcc', 'clang'],
            "\}
" vim: fdm=marker
