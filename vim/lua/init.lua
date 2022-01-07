local keymap = vim.api.nvim_set_keymap
local keymap_normal_opts = { noremap = true }

-- Configuración del administrador de plugins {{{

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'rafi/awesome-vim-colorschemes'
end)

-- }}}

-- Variables definidas por mi {{{
local envolver_lineas_largas = true
local usar_portapapeles_del_sistema = false
local usar_respaldo_local = true
-- }}}

-- ##### Configuración general ##### {{{
vim.o.mouse = 'a'	-- Usar el ratón para mover/seleccionar/etc...

-- Caracteres de apertura y cierre
vim.o.showmatch = true	    -- Resaltar los paréntesis/corchetes correspondientes
-- Saltar también entre paréntesis angulares hermanos
vim.o.matchpairs = vim.bo.matchpairs .. ',<:>'
-- % - Alternar entre inicio y final de (){}[], etc..

-- Tecla prefijo
vim.g.mapleader = ','  -- Se usa como prefijo para comandos al mapear <leader>{algo}

-- Activar detección del tipo de archivo
vim.cmd [[filetype plugin indent on]]
-- ##### }}}

--- ##### Información visible en pantalla ##### {{{
vim.o.title = true	-- Nombre de archivo en barra de título

vim.o.showcmd = true	-- Mostrar en una esquina lo que has presionado hasta ahora
vim.o.showmode = true	-- Mostrar el modo actual
vim.o.ruler = true	-- Mostrar línea y columna actuales en la barra de estado

-- Menú de modo comando
vim.o.wildmode = 'longest,full'
vim.o.wildignore = '*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn'

-- Mostrar números de línea (posición actual en absoluto + el resto en relativo)
vim.o.number = true            -- Mostrar número de línea global
vim.o.relativenumber = true    -- Mostrar númeración relativa
vim.o.numberwidth = 3          -- Columnas mínimas para mostrar número de línea

-- Formato y longitud del texto
vim.o.textwidth = 80           -- Longitud de texto
vim.o.colorcolumn = '+1'       -- Hacer que se resalte una columna "límite" en
                                -- textwidth + 1, kj

vim.cmd [[
augroup LongitudesArchivosEspeciales
    autocmd!
    autocmd FileType gitcommit setlocal spell textwidth=72
augroup END
]]

--- ##### }}}

--- ##### Sintaxis, indentación y caracteres invisibles ##### {{{
-- Reglas generales {{{
vim.cmd [[syntax on]]       -- Activamos la sintaxis
vim.o.synmaxcol = 200       -- Solo se resaltan los primeros 200 caracteres

vim.g.tema_actual = 'PaperColor'

local comando = 'colorscheme ' .. vim.g.tema_actual
vim.cmd(comando)

-- Lista de colores para recorrerlos mediante un
--local lista_colores = {
--    '256_noir', 'PaperColor', 'abstract', 'alduin', 'angr', 'apprentice',
--    'challenger_deep', 'deus', 'gruvbox', 'gotham256', 'hybrid',
--    'hybrid_material', 'jellybeans', 'lightning', 'lucid', 'lucius',
--    'materialbox', 'meta5', 'minimalist', 'molokai', 'molokayo', 'nord', 'one',
--    'onedark', 'paramount', 'rdark-terminal2', 'scheakur', 'seoul256-light',
--    'sierra', 'tender', 'two-firewatch'
--}
--
--local posicion_actual_colorscheme = -1
--for k, v in pairs(lista_colores) do
--    if v == vim.g.tema_actual then
--        posicion_actual_colorscheme = k
--    end
--end
vim.cmd [[
let s:lista_colores = [ '256_noir', 'PaperColor',
    \ 'abstract', 'alduin', 'angr', 'apprentice', 'challenger_deep',
    \ 'deus', 'gruvbox', 'gotham256', 'hybrid', 'hybrid_material',
    \ 'jellybeans', 'lightning', 'lucid', 'lucius', 'materialbox',
    \ 'meta5', 'minimalist', 'molokai', 'molokayo', 'nord', 'one',
    \ 'onedark', 'paramount', 'rdark-terminal2', 'scheakur',
    \ 'seoul256-light', 'sierra', 'tender', 'two-firewatch' ]

let s:posicion_actual = index(s:lista_colores, g:tema_actual)

function! RotarColor()
    let s:posicion_actual = (s:posicion_actual + 1) % len(s:lista_colores)
    let g:tema_actual = s:lista_colores[s:posicion_actual]
    execute 'colorscheme ' . g:tema_actual

    for l:color in ['two-firewatch', 'lucid', 'paramount']
        if l:color ==# s:lista_colores[s:posicion_actual]
            set background=dark
        endif
    endfor
    for l:color in ['256_noir']
        if l:color ==# s:lista_colores[s:posicion_actual]
            set background=light
        endif
    endfor
    call ColoresPersonalizados(g:tema_actual)
endfunction
]]

keymap('n', '<leader>cr', ':call RotarColor()<Return>', keymap_normal_opts)

-- Se define que un par de cosas sean más visibles
vim.cmd [[
function! ColoresPersonalizados(tema)
    if a:tema ==# 'tender'
        highlight SpellBad guibg=NONE guifg=#f43753 ctermbg=NONE ctermfg=203
        highlight SpellCap guibg=NONE guifg=#9faa00 ctermbg=NONE ctermfg=142
        highlight SpellRare guibg=NONE guifg=#d3b987 ctermbg=NONE ctermfg=180
        highlight SpellLocal guibg=NONE guifg=#ffc24b ctermbg=NONE ctermfg=215

        highlight ColorColumn guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=0 gui=NONE cterm=NONE
        highlight CursorColumn guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=0 gui=NONE cterm=NONE
        highlight CursorLine guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=0 gui=NONE cterm=NONE
        highlight LineNr guifg=#b3deef ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
        highlight Comment guifg=#c9d05c ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
        highlight FoldColumn guifg=#ffffff ctermfg=15 guibg=#202020 ctermbg=234 gui=NONE cterm=NONE
    endif
endfunction
call ColoresPersonalizados(g:tema_actual)
]]

-- Caracteres invisibles
vim.o.list = true       -- Mostrar caracteres invisibles según las reglas de 'listchars'
vim.o.listchars = 'tab:»·,trail:·,extends:❯,precedes:❮'

vim.o.conceallevel = 2      -- Permite texto "camuflajeado"
vim.o.concealcursor = ''    -- Desactiva el "camuflaje" para la líena actual

-- }}}

--- Resaltado de elementos {{{
-- Resaltar la línea y la columna actual
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Crear una clasificación de color llamada "EspaciosEnBlancoExtra"
vim.cmd [[highlight EspaciosEnBlancoExtra ctermbg=172 guifg=#D78700]]
-- Resalta la expresión regular "\s\+$" como "EspaciosEnBlancoExtra"
vim.cmd [[match EspaciosEnBlancoExtra /\s\+$/]]

-- Resaltar señales de conflicto en un merge de git
vim.cmd [[highlight Conflicto ctermbg=1 guifg=#FF2233]]
vim.cmd [[2match Conflicto /\v^(\<|\=|\>){7}([^=].+)?$/]]
-- }}}

--- Tabulado y sangría {{{
-- Cambia tres opciones por el precio de una llamada a función
-- Ejemplo de uso:
--    :call CambiarIndentacion(8)<Return>
-- Si se quiere una re-indentación automática de todo el texto ya existente
-- pasar un argumento extra sin importar su valor. Ejemplo:
--    :call CambiarIndentacion(8, 'reindenta')<Return>
vim.cmd [[
function! CambiarIndentacion(espacios, ...)
    let &tabstop     = a:espacios
    let &shiftwidth  = a:espacios
    let &softtabstop = a:espacios

    if len(a:000)
        execute "normal! gg=G\<C-o>\<C-o>"
    endif
endfunction
call CambiarIndentacion(4)
]]

-- Otras configuraciones con respecto a la sangría
vim.o.expandtab   = true    -- Se sangra el código con espacios
vim.o.autoindent  = true    -- Añade la sangría de la línea anterior automáticamente
vim.o.smartindent = true    -- Aplicar sangría cuando sea necesario
vim.o.shiftround  = true    -- Redondear el nivel de sangría
vim.o.smarttab    = true    -- Usar tabs de acuerdo a 'shiftwidth'
vim.o.signcolumn = 'auto:1-9'  -- Espacio para símbolos al lado de los números
--- }}}

--- ##### }}}

--- ##### Ventanas, buffers y navegación ##### {{{
--- General {{{
vim.o.scrolloff     = 2         -- Mínimas líneas por encima/debajo del cursor
vim.o.sidescrolloff = 5         -- Mínimas columnas por la izquierda/derecha

-- Especificamos cuando se puede mover el cursor más allá del fin de línea
vim.o.virtualedit   = 'block,onemore'


-- Configuración de lineas largas
vim.o.linebreak = true

if envolver_lineas_largas then
    vim.o.wrap = true   -- Si el texto se sale de pantalla, se muestra debajo
    -- No mostrar símbolos @▀ cuando la línea no cabe
    vim.o.display = vim.o.display .. ',lastline'
    -- En líneas largas, se muestran ... de continuación
    vim.o.showbreak = '... '
    -- Se aplica sangría a la continuación de línea
    vim.o.breakindent = true
else
    vim.o.wrap = false
end

-- Las flechas y el backspace dan la vuelta a través de las líneas
vim.o.whichwrap='b,s,h,l,<,>,[,]'
--- }}}

--- Ventanas {{{
-- Dirección para abrir nuevas ventanas (splits)
vim.o.splitright = true  -- Las separaciones verticales se abren a la derecha
vim.o.splitbelow = true  -- Las separaciones horizontales se abren hacia abajo

-- diffsplit prefiere orientación vertical
vim.o.diffopt = vim.o.diffopt .. ',vertical'

-- Comandos para abrir y cerrar nuevas ventanas (splits)
keymap('n', '|', ':<C-u>vsplit<Space>', keymap_normal_opts)
keymap('n', '_', ':<C-u>split<Space>', keymap_normal_opts)

-- Redimensionar las ventanas
vim.cmd [[
nnoremap <C-w>- :<C-u>call RepetirRedimensionadoVentana('-', v:count)<Return>
nnoremap <C-w>+ :<C-u>call RepetirRedimensionadoVentana('+', v:count)<Return>
nnoremap <C-w>< :<C-u>call RepetirRedimensionadoVentana('<', v:count)<Return>
nnoremap <C-w>> :<C-u>call RepetirRedimensionadoVentana('>', v:count)<Return>

function! RepetirRedimensionadoVentana(inicial, cuenta)
    let l:tecla = a:inicial
    let l:cuenta = a:cuenta ? a:cuenta : 0
    while stridx('+-><', l:tecla) != -1 || l:tecla =~# '\d'
        if l:tecla =~# '\d'
            let l:cuenta = l:cuenta * 10 + l:tecla
        else
            execute l:cuenta . 'wincmd ' . l:tecla
            let l:cuenta = 0
            redraw
        endif
        let l:tecla = nr2char(getchar())
    endwhile
endfunction
]]

-- Mantener igualdad de tamaño en ventanas cuando el marco se redimensiona
vim.cmd [[
augroup TamanioVentana
    autocmd!
    autocmd VimResized * :wincmd =
augroup end
]]
-- }}}

-- Tabulaciones {{{
vim.o.tabpagemax = 15   -- Solo mostrar 15 tabs

-- Comandos para abrir y cerrar tabulaciones
keymap('n', '<Leader>tn', ':tabnew<Space>', keymap_normal_opts)
keymap('n', '<Leader>to', ':tabonly<Return>', keymap_normal_opts)

-- Moverse entre tabulaciones
keymap('n', '<Leader>th', ':tabfirst<Return>', keymap_normal_opts)
keymap('n', '<Leader>tl', ':tablast<Return>', keymap_normal_opts)
keymap('n', '<Leader>tj', ':tabprevious<Return>', keymap_normal_opts)
keymap('n', '<Leader>tk', ':tabnext<Return>', keymap_normal_opts)

-- Mover la tabulación actual
keymap('n', '<Leader>t-', ':tabmove -<Return>', keymap_normal_opts)
keymap('n', '<Leader>t+', ':tabmove +<Return>', keymap_normal_opts)
keymap('n', '<Leader>t<', ':tabmove 0<Return>', keymap_normal_opts)
keymap('n', '<Leader>t>', ':tabmove $<Return>', keymap_normal_opts)

-- Un "modo" especial que abrevia las operaciones con tabulaciones
vim.cmd [[
nnoremap <silent> <Leader>tm :<C-u>call ModoAccionTabulacion()<Return>

function! ModoAccionTabulacion()
    if tabpagenr('$') == 1
        echomsg 'Modo tab requere más de una tabulación'
        return
    endif

    echomsg 'Modo tab. hljk+->< para controlar tabs, cualquier otra cosa para salir'
    let l:tecla = nr2char(getchar())
    let l:aciones = {
                \'h': 'tabfirst',    'l': 'tablast',
                \'j': 'tabprevious', 'k': 'tabnext',
                \'<': 'tabmove 0',   '>': 'tabmove $'
                \}

    while stridx('hljk+-><', l:tecla) != -1
        if stridx('hljk><', l:tecla) != -1
            execute l:aciones[l:tecla]
        else
            if (l:tecla ==# '+' && tabpagenr() != tabpagenr('$'))
                        \ || (l:tecla ==# '-' && tabpagenr() != 1)
                execute 'tabmove ' . l:tecla
            endif
        endif
        redraw
        let l:tecla = nr2char(getchar())
    endwhile
endfunction
]]
-- }}}

-- Buffers {{{
vim.o.hidden = true                 -- Permitir buffers ocultos
vim.o.switchbuf = 'useopen,usetab'  -- Preferir tabs/ventanas al cambiar buffer

-- Abrir y moverse entre buffers
keymap('n', '<Leader>bn', ':edit<Space>', keymap_normal_opts)
keymap('n', '<Leader>bg', ':ls<Return>:buffer<Space>', keymap_normal_opts)
keymap('n', '<Leader>bh', ':bfirst<Return>', keymap_normal_opts)
keymap('n', '<Leader>bk', ':bnext<Return>', keymap_normal_opts)
keymap('n', '<Leader>bj', ':bprevious<Return>', keymap_normal_opts)
keymap('n', '<Leader>bl', ':last<Return>', keymap_normal_opts)

-- Cerrar ventana, buffer o tabulaciones
keymap('n', '<Leader>bd', ':bdelete!<Return>', keymap_normal_opts)

-- Cambiar el directorio de trabajo al directorio del buffer actual
keymap('n', '<Leader>cd', ':cd %:p:h<Return>:pwd<Return>', keymap_normal_opts)
-- }}}

-- Movimiento en modo normal {{{
-- Moverse por líneas visuales en lugar de lineas lógicas
keymap('n', 'j',  'gj', keymap_normal_opts)
keymap('n', 'k',  'gk', keymap_normal_opts)
keymap('n', 'gj', 'j', keymap_normal_opts)
keymap('n', 'gk', 'k', keymap_normal_opts)

-- Moverse entre inicio/medio/final de la pantalla
vim.cmd [[
nnoremap <C-l> :call AlternarInicioMedioFinalComoEnEmacs()<return>
function! AlternarInicioMedioFinalComoEnEmacs()
    let l:lineas_ventana = (line('$') <= winheight('%') ? line('$') : winheight('%'))
    let l:linea_inicial = winline()

    normal! zb
    let l:linea_ultima = winline()

    if l:linea_inicial == l:linea_ultima
        normal! zt
    elseif l:linea_inicial != l:lineas_ventana / 2
         \ && l:linea_inicial != l:lineas_ventana / 2 + 1
        normal! z.
    endif

    redraw
endfunction
]]
-- }}}

-- Movimiento en modo comando {{{
keymap('c', '<C-a>', '<Home>', keymap_normal_opts)
keymap('c', '<C-b>', '<Left>', keymap_normal_opts)
keymap('c', '<C-f>', '<Right>', keymap_normal_opts)
keymap('c', '<A-b>', '<S-Left>', keymap_normal_opts)
keymap('c', '<A-f>', '<S-Right>', keymap_normal_opts)
keymap('c', '<C-d>', '<Del>', keymap_normal_opts)
keymap('c', '<A-d>', '<S-Right><C-w>', keymap_normal_opts)
keymap('c', '<A-D>', '<C-e><C-u>', keymap_normal_opts)

keymap('c', '<C-p>', '<Up>', keymap_normal_opts)
keymap('c', '<C-n>', '<Down>', keymap_normal_opts)

keymap('c', '<Up>',   '<C-p>', keymap_normal_opts)
keymap('c', '<Down>', '<C-n>', keymap_normal_opts)
-- }}}

-- Dobleces (folds) {{{
vim.o.foldenable = true         -- Habilitar dobleces
vim.o.foldcolumn = 'auto'       -- Una columna para mostrar la extensión de un dobles
vim.cmd [[set foldopen-=block]] -- No abrir dobleces al presionar }, ), etc...
vim.o.foldnestmax = 3           -- Máxima profundidad de los dobleces

-- Abrir y cerrar dobleces
keymap('n', '<Space>', 'za', keymap_normal_opts)

-- Función para doblar funciones automáticamente
keymap('n', '<Leader>faf', ':call DoblarFunciones()<Return>', keymap_normal_opts)
vim.cmd [[
function! DoblarFunciones()
    set foldmethod=syntax
    set foldnestmax=1
endfunction
]]
-- }}}
-- ##### }}}

--- ##### Ayudas en la edición ##### {{{
--- General {{{
vim.o.backspace  = '2'      -- La tecla de borrar funciona como en otros programas
vim.o.undolevels = 10000    -- Poder deshacer cambios hasta el infinito y más allá
vim.o.undofile   = true     -- Guardar historial de cambios tras salir

vim.o.undoreload = 10000    -- Cantidad de cambios que se preservan
vim.o.history    = 1000     -- Un historial de comandos bastante largo
-- El octal es confundible con decimal, así que paso de usar dicho formato
vim.cmd [[ set nrformats-=octal ]]

vim.o.nrformats = vim.o.nrformats .. ',alpha'  -- Aritmética con letras

vim.o.joinspaces = false -- No insertar dos espacios tras signo de puntuación
vim.o.lazyredraw = true  -- No redibujar la interfaz a menos que sea necesario
vim.o.updatetime = 500   -- Tiempo para que vim se actualice

vim.o.ttimeout = true    -- ttimeout y ttimeoutlen controlan el retraso de la
vim.o.ttimeoutlen = 1    -- interfaz para que <Esc> no se tarde

-- Rotar entre los diferentes modos visuales con v
vim.cmd [[
xnoremap <expr> v
               \ (mode() ==# 'v' ? 'V' : mode() ==# 'V' ?
               \ "\<C-v>" : 'v')
]]
-- }}}

-- Copiando, pegando y moviendo texto {{{

-- Definir el comportamiento del registro sin nombre
if usar_portapapeles_del_sistema and vim.fn['has']('clipboard') then
    if vim.fn['has']('unnamedplus') then
        -- Cuando se pueda usar el registro + para copiar-pegar
        vim.o.clipboard = 'unnamed,unnamedplus'
    else
        -- En mac y windows se usa el registro * para copiar-pegar
        vim.o.clipboard = 'unnamed'
    end
end

-- Manejo de registros por medio de la letra ñ
keymap('n', 'ñ', '"', keymap_normal_opts)
keymap('x', 'ñ', '"', keymap_normal_opts)

-- Hacer que Y actúe como C y D
keymap('n', 'Y', 'y$', keymap_normal_opts)

-- Mover lineas visuales hacia arriba y hacia abajo
vim.cmd [[
nmap <A-y> <Plug>(textmanip-duplicate-up)
xmap <A-y> <Plug>(textmanip-duplicate-up)
nmap <A-Y> <Plug>(textmanip-duplicate-down)
xmap <A-Y> <Plug>(textmanip-duplicate-down)

nmap <A-j> V<A-j><Esc>
xmap <A-j> <Plug>(textmanip-move-down)
nmap <A-k> V<A-k><Esc>
xmap <A-k> <Plug>(textmanip-move-up)

nmap <A-h> v<A-h><Esc>
xmap <A-h> <Plug>(textmanip-move-left)
nmap <A-l> v<A-l><Esc>
xmap <A-l> <Plug>(textmanip-move-right)

xmap <Up>     <Plug>(textmanip-move-up-r)
xmap <Down>   <Plug>(textmanip-move-down-r)
xmap <Left>   <Plug>(textmanip-move-left-r)
xmap <Right>  <Plug>(textmanip-move-right-r)
]]

-- Mantener el modo visual después de > y <
keymap('x', '<', '<gv', keymap_normal_opts)
keymap('x', '>', '>gv', keymap_normal_opts)
-- }}}

--- Operaciones comunes de modificación de texto {{{
-- j: Eliminar caracter de comentario al unir líneas
-- l: Partir líneas cuando se hagan muy largas
vim.o.formatoptions = vim.o.formatoptions .. ',j,l'

-- Regresar rápido a modo normal
keymap('i', 'kj', '<Esc>', keymap_normal_opts)

-- Seleccionando texto significativo
keymap('n', 'gV', '`[v`]', keymap_normal_opts) -- Texto previamente insertado

-- Texto previamente pegado
vim.cmd [[
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
]]

-- Seleccionar una columna de texto no vacío hacia arriba o hacia abajo en modo
-- de selección de columna
vim.cmd [[
xnoremap <leader><C-v>k :<C-u>call SeleccionarColumna('arriba')<CR>
xnoremap <leader><C-v>j :<C-u>call SeleccionarColumna('abajo')<CR>
xnoremap <leader><C-v>a :<C-u>call SeleccionarColumna('ambas-direcciones')<CR>

function! SeleccionarColumna(direccion)
    normal! gv

    let [l:_, l:num, l:col, l:_, l:_] = getcurpos()
    let l:suapped_position = 0
    if line("'>") == l:num && col("'>") == l:col
        normal! o
        let l:suapped_position = 1
    endif

    if a:direccion ==# 'arriba' || a:direccion ==# 'ambas-direcciones'
        while match(getline(line('.') - 1)[l:col - 1], '\_S') != -1
            normal! k
        endwhile
    endif

    normal! o
    if a:direccion ==# 'abajo' || a:direccion ==# 'ambas-direcciones'
        while match(getline(line('.') + 1)[l:col - 1], '\_S') != -1
            normal! j
        endwhile
    endif

    if !l:suapped_position
        normal! o
    endif
endfunction
]]

-- Eliminar texto hacia enfrente con comandos basados en la D
vim.cmd [[
inoremap <C-d> <Del>
inoremap <expr> <A-d> '<Esc>' . (col('.') == 1 ? "" : "l") . 'dwi'
inoremap <expr> <A-D> '<Esc>' . (col('.') == 1 ? "" : "l") . 'C'
]]

-- Regresar a modo normal eliminando la línea actual
keymap('i', '<A-k><A-j>', '<Esc>ddkk', keymap_normal_opts)
keymap('i', '<A-j><A-k>', '<Esc>ddj', keymap_normal_opts)

-- Añadir línea vacía por arriba y por debajo
keymap('n', '<A-o>', ":call append(line('.'), '')<Return>", keymap_normal_opts)
keymap('n', '<A-O>', ":call append(line('.')-1, '')<Return>", keymap_normal_opts)

-- Borrar todo de la línea de comandos excepto el propio comando
vim.cmd [[ cnoremap <A-w> <C-\>esplit(getcmdline(), " ")[0]<return><space> ]]

-- Aumentar la granularidad del undo
keymap('i', '<C-u>',    '<C-g>u<C-u>', keymap_normal_opts)
keymap('i', '<Return>', '<C-g>u<Return>', keymap_normal_opts)
-- }}}

--- ##### }}}

--- ##### Búsqueda y reemplazo ##### {{{
-- General {{{
vim.o.wrapscan  = true  -- Las búsquedas dan la vuelta al archivo
vim.o.incsearch = true  -- Hacer las búsquedas incrementales

vim.o.inccommand = 'nosplit' -- Hacer los remplazos incrementales

vim.o.ignorecase = true -- No diferenciar mayúsculas/minúsculas
vim.o.smartcase  = true -- Ignorecase si la palabra empieza por minúscula
vim.o.gdefault   = true -- Usar bandera 'g' por defecto en las sustituciones

-- Desactivar el resaltado de búsqueda
keymap('n', '//', ':nohlsearch<Return>', keymap_normal_opts)
--- }}}

--- Hacks para la búsqueda y remplazo {{{
-- Hacer que el comando . (repetir edición) funcione en modo visual
keymap('x', '.', ':normal .<Return>', keymap_normal_opts)

-- Repitiendo sustituciones con todo y sus banderas
keymap('n', '&', ':&&<Return>', keymap_normal_opts)
keymap('x', '&', ':&&<Return>', keymap_normal_opts)

-- Repitiendo el último comando de consola
keymap('n', 'Q', '@:', keymap_normal_opts)
keymap('x', 'Q', '@:', keymap_normal_opts)

-- No moverse cuando se busca con * y #
keymap('n', '*', '*N', keymap_normal_opts)
keymap('n', '#', '#N', keymap_normal_opts)

-- Usar * y # en modo visual busca texto seleccionado y no la palabra actual
vim.cmd [[
xnoremap * :<C-u>call SeleccionVisual()<Return>/<C-R>=@/<Return><Return>N
xnoremap # :<C-u>call SeleccionVisual()<Return>?<C-R>=@/<Return><Return>N

function! SeleccionVisual() range
    let l:registro_guardado = @"
    execute 'normal! vgvy'

    let l:patron = escape(@", "\\/.*'$^~[]")
    let l:patron = substitute(l:patron, "\n$", '', '')

    let @/ = l:patron
    let @" = l:registro_guardado
endfunction
]]

-- Ver la línea de la palabra buscada en el centro
keymap('n', 'n', 'nzzzv', keymap_normal_opts)
keymap('n', 'N', 'Nzzzv', keymap_normal_opts)

--- }}}

--- Comandos nuevos (mapeos) {{{
-- Buscar texto en todos los buffers abiertos
vim.cmd [[
command! -nargs=1 BuscarBuffers call BuscarBuffers(<q-args>)

function! BuscarBuffers(patron)
    let l:archivos = map(filter(range(1, bufnr('$')), 'buflisted(v:val)'),
                \ 'fnameescape(bufname(v:val))')
    try
        silent noautocmd execute 'lvimgrep /' . a:patron . '/gj ' . join(l:archivos)
    catch /^Vim\%((\a\+)\)\=:E480/
        echomsg 'No hubo coincidencias'
    endtry
    lwindow
endfunction
]]

-- Reemplazar texto -- TODO, poner mi plugin en su lugar
keymap('n', '<Leader>ss', ':s/', keymap_normal_opts)
keymap('x', '<Leader>ss', ':s/', keymap_normal_opts)
keymap('n', '<Leader>se', ':%s/', keymap_normal_opts)
keymap('x', '<Leader>se', ':<C-u>call SeleccionVisual()<Return>:%s/<C-r>=@/<Return>/', keymap_normal_opts)
keymap('n', '<Leader>sw', ':%s/\\<<C-r><C-w>\\>\\C/', keymap_normal_opts)
keymap('n', '<Leader>sW', ':%s/<C-r>=expand("<cWORD>")<Return>\\C/', keymap_normal_opts)

-- }}}
--- ##### }}}

--- ##### Guardando, saliendo y regresando a vim ##### {{{
vim.o.fileformats = 'unix,dos,mac'  -- Formato para los saltos de línea
vim.o.autowrite   = true            -- Guardado automático en ciertas ocasiones
vim.o.autoread    = true            -- Recargar el archivo si hay cambios

-- Respaldos y recuperación en caso de fallos {{{

if usar_respaldo_local then
    vim.o.backup     = true
    vim.o.backupcopy = 'yes'
else
    vim.o.backup      = false
    vim.o.writebackup = false
    vim.o.swapfile    = false
end

-- configurar lo que se guarda en un archivo de sesión
-- unix: el archivo de sesión se guarda en estilo unix
-- slash: las rutas de archivo se guardan con '/' en lugar de '\'
vim.o.sessionoptions = vim.o.sessionoptions .. ',localoptions,unix,slash'

-- }}}

--- Comandos y acciones automáticas para abrir, guardar y salir {{{
-- Comandos para salir de vim desde modo normal
keymap('n', 'ZG', ':xa<Return>', keymap_normal_opts)
keymap('n', 'ZA', ':quitall!<Return>', keymap_normal_opts)

-- Para que shift en modo comando no moleste
vim.cmd [[
command! -bang -nargs=* -complete=file E  e<bang> <args>
command! -bang -nargs=* -complete=file W  w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wqa wqa<bang>
command! -bang WQa wqa<bang>
command! -bang WQA wqa<bang>
command! -bang Xa xa<bang>
command! -bang XA xa<bang>
]]

-- Usar Ctrl-s para guardar como en cualquier otro programa
keymap('n', '<C-s>', ':update<Return>', keymap_normal_opts)
keymap('i', '<C-s>', '<Esc>:update<Return>a', keymap_normal_opts)

vim.cmd [[
augroup ComandosAutomaticosGuardarLeer
    autocmd!
    " Eliminar espacios sobrantes cada que se guarde el archivo
    " (Si no quieres que esto pase, comenta esta línea con un ")
    autocmd BufWritePre * :%s/\s\+$//e

    " Abrir vim en la última posición editada del archivo
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                \ |           execute "normal! g`\""
                \ |       endif

    " Re-Cargar la configuración cuando se guarde
    autocmd BufWritePost $MYVIMRC source $MYVIMRC

    " Si se intenta editar un archivo en un directorio inexistente
    autocmd BufNewFile * call CrearDirectorioSiNoExiste()
augroup END

function! CrearDirectorioSiNoExiste()
    let l:dir_requerido = expand('%:h')
    if !isdirectory(l:dir_requerido)
        let l:respuesta = confirm('El directorio ' . l:dir_requerido
                    \ . ' no existe. ¿Quieres crearlo?',
                    \   "&Si\n&No", 1)

        if l:respuesta != 1
            return
        endif

        try
            call mkdir(l:dir_requerido, 'p')
        catch
            echoerr 'No se ha podido crear ' . l:dir_requerido
        endtry
    endif
endfunction
]]
-- }}}

-- Configuración para archivos grandes {{{
vim.cmd [[
augroup ArchivoGrande
    let s:TAMANIO_GRANDE = 10 * 1024 * 1024
    autocmd!
    autocmd BufReadPre * let s:tamanio = getfsize(expand("<afile>"))
                \ | if s:tamanio > s:TAMANIO_GRANDE || s:tamanio == -2
                \ |     call ArchivoGrande()
                \ | endif
augroup END

function! ArchivoGrande()
    " Esta función es llamada cuando el archivo supera 10M de longitud
    syntax off
    set eventignore+=FileType  " Sin resaltado y demás cosas dependientes del tipo
    setlocal bufhidden=unload  " Guardar memoria cuando otro archivo es usado
    setlocal undolevels=-1     " Sin historial de cambios
    setlocal nospell           " Sin revisión ortográfica"
endfunction
]]
--- }}}
--- ##### }}}

--- ##### Compilación, revisión de errores y cosas específicas de un lenguaje ##### {{{
--- Comandos de compilación y ejecución {{{
vim.g.op_compilacion = {
    archivos = '%',
    nombre_ejecutable = '%:t:r'
}

vim.g.op_compilacion.c = {
    compilador = 'gcc',
    banderas = '-std=gnu11 -Wall -Wextra -Wno-missing-field-initializers -Wstrict-prototypes',
    salida = '-o'
}

vim.g.op_compilacion.cpp = {
    compilador = 'g++',
    banderas = '-std=c++14 -Wall -Wextra',
    salida = '-o'
}

vim.g.op_compilacion.fortran = {
    compilador = 'gfortran',
    banderas = '-Wall -Wextra',
    salida = '-o'
}

vim.g.op_compilacion.java = {
    compilador = 'javac',
    banderas = '',
    salida = ''
}

vim.g.op_compilacion.cs = {
    compilador = 'mcs',
    banderas = '',
    salida = ''
}

vim.g.op_compilacion.haskell = {
    compilador = 'ghc',
    banderas = '-dynamic',
    salida = ''
}

-- En python/bash/ruby y otros interpretados se revisa el código
vim.g.op_compilacion.python = {
    compilador = 'flake8',
    banderas = '',
    salida = ''
}

vim.g.op_compilacion.sh = {
    compilador = 'bash -n',
    banderas = '',
    salida = ''
}

vim.cmd [=[
let g:comando_compilacion = {}
function! ActualizarComandosCompilacion()
    let l:dict = {}
    for l:el in items(g:op_compilacion)
        let l:op = l:el[1]
        if !exists('g:usar_make_personalizado') || g:usar_make_personalizado == 0
            let l:dict[l:el[0]] = l:op['compilador'] . ' '

            let l:dict[l:el[0]] .= l:op['salida'] . ' '
            if (!empty(l:op['salida']))
                let l:dict[l:el[0]] .= g:op_compilacion['nombre_ejecutable'] . ' '
            endif

            let l:dict[l:el[0]] .= g:op_compilacion['archivos'] . ' '
            let l:dict[l:el[0]] .= l:op['banderas']

            let g:comando_compilacion[l:el[0]] = l:dict[l:el[0]]
        else
            let g:comando_compilacion[l:el[0]] = 'make'
        endif
    endfor
endfunction
call ActualizarComandosCompilacion()
]=]

--function! GenerarArchivoConfiguracion()
--    if &filetype ==# ''
--        let g:tipo_archivo = input('Ingresa el lenguaje: ')
--    else
--        let g:tipo_archivo = &filetype
--    endif
--
--    if filereadable(expand('~/.vimtags'))
--        silent !rm ~/.vimtags
--    endif
--
--    if filereadable('./.exrc')
--        tabnew .exrc
--        return
--    endif
--
--    let l:lineas_archivo = [
--            \ '" Opciones locales para vim:',
--            \ 'scriptencoding utf-8',
--            \ 'call CambiarIndentacion(4) " Espacios por tab',
--            \ '',
--            \ '" Configuración para el compilador:',
--            \ "let g:op_compilacion.archivos = '" . expand('%') . "'",
--            \ "let g:op_compilacion.nombre_ejecutable = '" . expand('%:t:r') . "'",
--            \ "let g:op_compilacion['" . g:tipo_archivo . "'] = {" ]
--    if has_key(g:op_compilacion, g:tipo_archivo)
--        let l:ops = g:op_compilacion[g:tipo_archivo]
--        let l:lineas_archivo += [
--                \ "\\ 'compilador': '" . l:ops.compilador . "',",
--                \ "\\ 'banderas': '" . l:ops.banderas . "',",
--                \ "\\ 'salida': '" . l:ops.salida . "'" ]
--    else
--        let l:lineas_archivo += [
--                \ "\\ 'compilador': '',",
--                \ "\\ 'banderas': '',",
--                \ "\\ 'salida': ''" ]
--    endif
--
--    let l:lineas_archivo += [
--            \ '\}',
--            \ '',
--            \ 'let g:usar_make_personalizado = 0',
--            \ 'call ActualizarComandosCompilacion()' ]
--
--    tabnew .exrc
--    call append(0, l:lineas_archivo)
--    normal! gg=G
--endfunction
--
--function! AplicarConfiguracion()
--    update
--    tabprevious
--    source .exrc
--    let &makeprg = g:comando_compilacion['c']
--    tabnext
--endfunction
--
--augroup makecomnads " Definiendo :make según el tipo de archivo
--    autocmd!
--    autocmd Filetype c       let &l:makeprg = g:comando_compilacion['c']
--    autocmd Filetype cpp     let &l:makeprg = g:comando_compilacion['cpp']
--    autocmd Filetype fortran let &l:makeprg = g:comando_compilacion['fortran']
--    autocmd Filetype java    let &l:makeprg = g:comando_compilacion['java']
--    autocmd Filetype python  let &l:makeprg = g:comando_compilacion['python']
--    autocmd Filetype cs      let &l:makeprg = g:comando_compilacion['cs']
--    autocmd Filetype sh      let &l:makeprg = g:comando_compilacion['sh']
--    autocmd Filetype haskell let &l:makeprg = g:comando_compilacion['haskell']
--augroup END
--
--" F9 para compilar y ejecutar
--nnoremap <F9> :call EjecutarSiNoHayErrores()<Return>
--
--function! EjecutarSiNoHayErrores()
--    if g:usar_make_personalizado || &makeprg !=# 'make'
--        make
--    endif
--
--    if len(getqflist()) ==# 0
--        " Si no hay errores se intenta ejecutar el programa
--        if ( &filetype ==# 'c' ||
--                    \ &filetype ==# 'cpp' ||
--                    \ &filetype ==# 'haskell' ||
--                    \ &filetype ==# 'fortran')
--
--            execute '!./' . g:op_compilacion['nombre_ejecutable']
--        elseif (&filetype ==# 'java')
--            execute '!./' . g:op_compilacion['nombre_ejecutable']
--        elseif (&filetype ==# 'python')
--            !python3 %
--        elseif (&filetype ==# 'sh')
--            !bash %
--        elseif (&filetype ==# 'html')
--            !xdg-open %
--        endif
--    else
--        " Si hay errores se abren en una lista interna
--        copen
--        setlocal nospell
--    endif
--endfunction
--"   +++ }}}
--
--" +++ Revisión de código +++ {{{
--if s:usar_plugins >= 2 && (has('nvim') || (v:version >= 800))
--    let g:ale_set_quickfix = 1
--    let g:ale_cpp_clangcheck_options = "-extra-arg='" . g:op_compilacion['cpp'].banderas
--    let g:ale_cpp_gcc_options = g:op_compilacion['cpp'].banderas
--    let g:ale_cpp_clang_options = g:op_compilacion['cpp'].banderas
--    let g:ale_cpp_clangtidy_options = g:op_compilacion['cpp'].banderas
--    let g:ale_c_gcc_options = g:op_compilacion['c'].banderas
--    let g:ale_c_clang_options = g:op_compilacion['c'].banderas
--    let g:ale_c_clangtidy_options = g:op_compilacion['c'].banderas
--    let g:ale_c_clangtidy_checks = ['*', '-readability-braces-around-statements',
--                \'-google-readability-braces-around-statements', '-llvm-header-guard']
--    let g:ale_haskell_ghc_options = g:op_compilacion['haskell'].banderas
--    let g:ale_fortran_gcc_options = g:op_compilacion['fortran'].banderas
--elseif s:usar_plugins
--    let g:syntastic_cpp_compiler_options = g:op_compilacion['cpp'].banderas
--    let g:syntastic_c_compiler_options = g:op_compilacion['c'].banderas
--    let g:syntastic_haskell_compiler_options = g:op_compilacion['haskell'].banderas
--    let g:syntastic_fotran_compiler_options = g:op_compilacion['fortran'].banderas
--endif
--"   +++ }}}
--
--" +++ Detección de tipos de archivo, y configuraciones locales +++ {{{
--augroup DeteccionLenguajes
--    autocmd!
--    autocmd BufNewFile,BufRead *.nasm setlocal filetype=nasm
--    autocmd BufNewFile,BufRead *.jade setlocal filetype=pug
--    autocmd BufNewFile,BufRead *.h    setlocal filetype=c
--augroup END
--
--augroup ConfiguracionesEspecificasLenguaje
--    autocmd!
--    " autocmd Filetype html,css,scss,sass,pug,php setlocal ts=2 sw=2 sts=2
--    " Los guiones normales forman parte del identificador en css
--    autocmd Filetype html,css,scss,sass,pug     setlocal iskeyword+=-
--    if s:usar_plugins >= 1
--        autocmd Filetype html,xml,jade,pug,htmldjango,css,scss,sass,php imap <buffer> <expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")
--    endif
--augroup END
--
--" Alternar entre archivo de ayuda y de texto (toggle text and help)
--nnoremap <leader>tth :call AlternarAyudaYTexto()<Return>
--function! AlternarAyudaYTexto()
--    let &filetype = (&filetype ==# 'help' ? 'text' : 'help')
--endfunction
--
--augroup ConfiguracionComandoK
--    autocmd!
--    " Por defecto se usa el comando :Man a su vez llama al man del sistema
--    autocmd FileType vim,help setlocal keywordprg=:help
--    " Se requiere tener instalado cppman para usar ayuda en c++
--    autocmd FileType cpp nnoremap <buffer> K yiw:sp<CR>:terminal<CR>Acppman <C-\><C-n>pA<CR>
--augroup end
--"   +++ }}}
--" ### }}}

-- vim: foldmethod=marker
