" ConfiguraciOn general {
    " ConfiguraciOn vim
    scriptencoding utf-8
    filetype off

    " ConfiguraciOn texto y navegaciOn
    set fileformat=unix   " De observa el ^M en los archivos modo dos
    set textwidth=100
    set ruler
    set showcmd
    set showmatch
    set matchpairs+=¡:!

    set number
    set relativenumber " NumeraciOn de lIneas desde tu posiciOn actual
    set linebreak
    set showbreak=...\              " Se muestran 3 puntos para simbolizar continuaciOn
    if has('patch-7.4.354') || has('nvim')
        set breakindent
    endif
    set undolevels=1000
    set backspace=indent,eol,start

    " ConfiguraciOn para la busqueda
    set hlsearch
    set smartcase
    set ignorecase
    set incsearch

    " Apertura de archivos en menú de modo ex
    "set path+=**       " BUsqueda recursiva de archivos
    set wildmenu        " Visualizar las opciones del menu ex tab con tab
    set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

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
    set nobackup
    set visualbell
    set autowrite
    set spell
    set spelllang=es
    set splitright
    set splitbelow
    set nrformats+=alpha
    set lazyredraw
    if has('conceal')
        set concealcursor=
    endif
" }

" Plugins y sus configuraciones {
    " Fijar la ruta en tiempo de ejecuciOn para incluir Vundle e inicializarlo
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Manejo de paquetes y repositorios
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'

    " Completado y revisiOn de cOdigo
    if has('nvim')                          " Ventana de auto-completado
        Plugin 'Shougo/deoplete.nvim'
    else
        if v:version >= 800 && has('python3')
            Plugin 'Shougo/deoplete.nvim'
            Plugin 'roxma/nvim-yarp'
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
    Plugin 'fortran.vim'
    "Plugin 'ternjs/tern_for_vim'            " Completado de javascript
    Plugin 'jcommenter.vim'                 " Javadoc
    Plugin 'davidhalter/jedi-vim'           " Completado de python
    Plugin 'carlitux/deoplete-ternjs'       " Completado de js
    Plugin 'vim-utils/vim-man'              " Visualizar manuales dentro de vim
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
    Plugin 'kana/vim-textobj-entire'        " Objeto de texto 'todo'
    Plugin 'Julian/vim-textobj-variable-segment' " Segmento de variable
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
    Plugin 'ryanoasis/vim-devicons'         " Iconos para los archivos
    Plugin 'ap/vim-css-color'               " Colorear valores RGB
    "Plugin 'Rykka/colorv.vim'
    "Plugin 'mattn/webapi-vim'
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

    " Otros plugins interesantes
    "Plugin 'thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/plugin/SWTC.vim'
    "Plugin 'sokoban.vim'
    "Plugin 'johngrib/vim-game-code-break'

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

    inoremap <expr><C-g> neocomplete#undo_completion()

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

    " ConfiguraciOn de easy-align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " ConfiguraciOn de ale / Syntastic
    if has('nvim') || (v:version >= 800)
        let g:ale_set_quickfix = 1
        let g:ale_cpp_clangcheck_options = "-extra-arg='-std=c++14 -Wall -Wextra"
        let g:ale_cpp_gcc_options = '-std=c++14 -Wall -Wextra'
        let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wextra'
        let g:ale_c_gcc_options = '-pthread -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/mirclient -I/usr/include/mircore -I/usr/include/mircookie -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -Wall -Wextra -std=gnu11'
        let g:ale_c_clang_options = '-pthread -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/mirclient -I/usr/include/mircore -I/usr/include/mircookie -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -Wall -Wextra -std=gnu11'
        let g:ale_haskell_ghc_options = '-dynamic'
        let g:ale_fortran_gcc_options = '-Wall -Wextra'
    else
        let g:syntastic_cpp_compiler_options = '-std=c++17 -Wall -Wextra'
        let g:syntastic_c_compiler_options = '-pthread -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/mirclient -I/usr/include/mircore -I/usr/include/mircookie -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -Wall -Wextra -std=gnu11'
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

    " ConfiguraciOn de vim-devicons
    set guifont=DroidSansMono\ Nerd\ Font\ 11

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
    augroup end
    " Definiendo el make
    augroup makecomnads
        autocmd!
        autocmd Filetype c          setlocal makeprg=gcc\ `pkg-config\ --cflags\ gtk+-3.0`\ %\ -std=c11\ -o\ %:t:r\ -Wall\ -lm\ `pkg-config\ --libs\ gtk+-3.0`
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
        autocmd BufEnter *.h setlocal filetype=c
        autocmd Filetype html,xml,jade,pug,htmldjango,css,scss,sass,php imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
        autocmd Filetype html,css,scss,sass,pug,php setlocal ts=2 sw=2 sts=2
        autocmd Filetype html,css,scss,sass,pug setlocal iskeyword+=-
    augroup end
" }

" Mapeos {

    " Mapeos bAsicos
    let g:mapleader = ','
    nnoremap Q <nop>
    inoremap kj <Esc>
    nnoremap <C-k> -l
    nnoremap <C-j> +l
    nnoremap <space> za
    nnoremap Y y$
    nmap <leader>ff zfaf
    nnoremap <leader>cbox :Tabularize /*<cr>vip<Esc>:substitute/ /=/g<cr>r A/<Esc>vipo<Esc>0r/:substitute/ /=/g<cr>:nohlsearch<cr>
    nnoremap <leader>r :%s/\<<C-r>=expand("<cword>")<CR>\>\C//g<Left><Left>
    nnoremap <leader>R :%s/\<<C-r>=expand("<cWORD>")<CR>\>\C//g<Left><Left>
    inoremap <leader>pk <Esc>:VCoolor<Return>a
    inoremap <leader>scp <Esc>:!gpick<Return>a

    " Operadores para el siguiente bloque
    onoremap in( :<c-u>normal! f)vi(<cr>
    onoremap in) :<c-u>normal! f)vi(<cr>
    vnoremap in( f(lo%h
    vnoremap in) f(lo%h
    onoremap an( :<c-u>normal! f)va(<cr>
    onoremap an) :<c-u>normal! f)va(<cr>
    vnoremap an( f(o%
    vnoremap an) f(o%

    onoremap ia( :<c-u>normal! F)vi(<cr>
    onoremap ia) :<c-u>normal! F)vi(<cr>
    vnoremap ia( F)oF)%ohol
    vnoremap ia) F)oF)%ohol
    onoremap aa( :<c-u>normal! F)va(<cr>
    onoremap aa) :<c-u>normal! F)va(<cr>
    vnoremap aa( F)oF)%
    vnoremap aa) F)oF)%

    onoremap in{ :<c-u>normal! f}vi{<cr>
    onoremap in} :<c-u>normal! f}vi{<cr>
    vnoremap in{ f{lo%h
    vnoremap in} f{lo%h
    onoremap an{ :<c-u>normal! f}va{<cr>
    onoremap an} :<c-u>normal! f}va{<cr>
    vnoremap an{ f{o%
    vnoremap an} f{o%

    onoremap ia{ :<c-u>normal! F}vi{<cr>
    onoremap ia} :<c-u>normal! F}vi{<cr>
    vnoremap ia{ F}oF}%ohol
    vnoremap ia} F}oF}%ohol
    onoremap aa{ :<c-u>normal! F}va{<cr>
    onoremap aa} :<c-u>normal! F}va{<cr>
    vnoremap aa{ F}oF}%
    vnoremap aa} F}oF}%

    onoremap in[ :<c-u>normal! F]vi[<cr>
    onoremap in] :<c-u>normal! F]vi[<cr>
    vnoremap in[ f[lo%h
    vnoremap in] f[lo%h
    onoremap an[ :<c-u>normal! f]va[<cr>
    onoremap an] :<c-u>normal! f]va[<cr>
    vnoremap an[ f[o%
    vnoremap an] f[o%

    onoremap ia[ :<c-u>normal! F]vi[<cr>
    onoremap ia] :<c-u>normal! F]vi[<cr>
    vnoremap ia[ F]oF]%ohol
    vnoremap ia] F]oF]%ohol
    onoremap aa[ :<c-u>normal! F]va[<cr>
    onoremap aa] :<c-u>normal! F]va[<cr>
    vnoremap aa[ F]oF]%
    vnoremap aa] F]oF]%

    onoremap in" :<c-u>normal! f"vi"<cr>
    vnoremap in" i"
    onoremap an" :<c-u>normal! f"va"<cr>
    vnoremap an" a"

    onoremap ia" :<c-u>normal! F"vi"<cr>
    vnoremap ia" F"o2F"loh
    onoremap aa" :<c-u>normal! F"va"<cr>
    vnoremap aa" 2F"oF"

    " Para modificar fácilmente este archivo
    nnoremap <leader>av :tabnew $MYVIMRC<CR>
    nnoremap <leader>sv :source $MYVIMRC<CR>

    " Manejo de ventanas
    nnoremap \| :vsplit<space>
    nnoremap _ :split<space>

    " Manejo de buffers
    nnoremap <leader>bn :edit<Space>

    nnoremap <leader>bk :bnext<CR>
    nnoremap <leader>bj :bprevious<CR>
    nnoremap <leader>bh :bfirst<CR>
    nnoremap <leader>bl :blast<CR>

    nnoremap <leader>bd :bdelete<CR>

    " Manejo de tabulaciones
    nnoremap <leader>tn :tabnew<Space>

    nnoremap <leader>tk :tabnext<CR>
    nnoremap <leader>tj :tabprev<CR>
    nnoremap <leader>th :tabfirst<CR>
    nnoremap <leader>tl :tablast<CR>
    nnoremap <leader>td :q<CR>

    " Abrir manuales desde el archivo
    augroup man
        autocmd!
        autocmd FileType c   nnoremap <buffer> <leader>F :Man <C-r><C-w>
        autocmd FileType cpp nnoremap <buffer> <leader>F :Man std::<C-r><C-w>
    augroup end

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
        nnoremap <leader>ot :5sp<CR>:te<CR><C-\><C-n>:setlocal nospell<CR>A
        tnoremap <Esc> <C-\><C-n>
        tmap     kj    <Esc>
    endif

    " Abrir fAcilmente el Arbol de directorios y de etiquetas
    noremap <F5> :NERDTreeToggle<Return>
    noremap <F6> :TagbarToggle<Return>

    " CorrecciOn de errores en el mismo archivo
    noremap <F9> :make<Return>:call Ejecutar()<Return>
" }

" Tema de color {
    " ConfiguraciOn de la paleta de colores
    syntax enable
    "set background=dark
    set t_Co=256            " Usar terminal con 256 colores
    "let g:solarized_termcolors=16
    colorscheme tender
" }
