local function keymap(mode, lhs, rhs, --[[Optional]] opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local has = vim.fn.has

-- ##### Configuración general ##### {{{
vim.o.mouse = 'a'	-- Usar el ratón para mover/seleccionar/etc...

-- Caracteres de apertura y cierre
vim.o.showmatch = true	    -- Resaltar los paréntesis/corchetes correspondientes
-- Saltar también entre paréntesis angulares hermanos
vim.o.matchpairs = vim.bo.matchpairs .. ',<:>'
-- % - Alternar entre inicio y final de (){}[], etc..

-- Tecla prefijo
vim.g.mapleader = ','  -- Se usa como prefijo para comandos al mapear <leader>{algo}

-- Rutas en las que vim busca archivos incluidos
--vim.o.path = vim.o.path .. ','

vim.o.exrc = true      -- Usar .vimrc y .exrc locales
vim.o.secure = true    -- Suprimir comandos inseguros en .exrc locales

-- Activar detección del tipo de archivo
vim.cmd [[filetype plugin indent on]]
-- ##### }}}

-- Configuración del administrador de plugins {{{

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'rafi/awesome-vim-colorschemes' --- Temas de color
    use 'godlygeek/Tabular'

    -- Utilidades generales
    use 't9md/vim-textmanip'
    -- xmap <Leader>tgtm <Plug>(textmanip-toggle-mode)
    -- nmap <Leader>tgtm <Plug>(textmanip-toggle-mode)
    use 'inkarkat/vim-ReplaceWithRegister'  -- Operador para remplazar texto
    use 'michaeljsmith/vim-indent-object' -- Objeto de texto 'indentado'
    use 'PeterRincker/vim-argumentative'  -- Objeto de texto 'argumento'
    use 'kana/vim-textobj-user'           -- Requerimiento de los próximos
    use 'kana/vim-textobj-function'       -- Objeto de texto 'función'
    use 'kana/vim-textobj-line'           -- Objeto de texto 'línea'
    use 'kana/vim-textobj-entire'         -- Objeto de texto 'buffer'
    use 'glts/vim-textobj-comment'        -- Objeto de texto 'comentario'
    use 'saulaxel/vim-next-object'        -- Objeto de texto 'siguiente elemento'
    use 'tpope/vim-surround'              -- Encerrar/liberar secciones
    use 'jiangmiao/auto-pairs'            -- Completar pares de símbolos
    use 'tpope/vim-commentary'            -- Operador para comentar código
    use 'tpope/vim-repeat'                -- Repetir plugins con .
    use 'jceb/vim-orgmode'                -- Organizar notas

    -- Servidores de revisión de código
    use 'vim-syntastic/syntastic'
    vim.g.syntastic_mode_map = {mode = 'passive'}

    use {
        'williamboman/nvim-lsp-installer',
        {
            'neovim/nvim-lspconfig',
            config = function()
            end
        }
    }

    -- Autocompletado
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Soporte de lenguajes
    use 'lervag/vimtex'
    use 'Konfekt/FastFold'
    use 'matze/vim-tex-fold'
    use 'mattn/emmet-vim'
    use 'sheerun/vim-polyglot'

    -- Revisión ortográfica y gramatical
    use {'rhysd/vim-grammarous', opt = true, cmd = {'GrammarousCheck'}}

    -- Estilo visual
    use 'Yggdroot/indentLine'
    use 'gregsexton/MatchTag'
    use 'ap/vim-css-color'
end)

-- Language protocol

vim.g.tex_flavor  = 'latex'
vim.g.tex_conceal = ''
vim.g.vimtex_fold_manual = 1
vim.g.vimtex_compiler_progname = 'nvr'
-- let g:vimtex_view_method = 'skim'

require('nvim-lsp-installer').setup {}
local lspconfig = require('lspconfig')

local servers = { 'sumneko_lua', 'clangd', 'jedi_language_server' }

local on_attach = function(client, bufnr)
    print(client)
    vim.bo.tagfunc = 'v:lua.vim.lsp.tagfunc'
    vim.bo.formatexpr = 'v:lua.vim.lsp.formatexpr'

    -- Permitir completar con <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mapeos
    -- Buscar ayuda para las siguientes funciones con `:help vim.lsp.*`
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>f', function()
        vim.lsp.buf.formatting { async = true }
    end, bufopts)

    keymap('n', '<Leader>lr', ':LspRestart<CR>')
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>h', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

-- nvim-cmp (Completion)
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            -- Se usa luasnip como motor de snippets
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.abort(),
        ['<C-e>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

---- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--    sources = cmp.config.sources({
--        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--    }, {
--        { name = 'buffer' },
--    })
--})
--
---- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline('/', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--        { name = 'buffer' }
--    }
--})
--
---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--        { name = 'path' }
--    }, {
--        { name = 'cmdline' }
--    })
--})

-- Lua snip
-- press <Tab> to expand or jump in a snippet
keymap('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true, silent = true, noremap = false })
-- Jump backwards
keymap('i', '<s-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true })


local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- lspconfig.ltex.setup {
--     settings = {
--         ltex = {
--             language = 'es'
--         }
--     }
-- }

lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

keymap('n', '<Leader>tb', ':Tabularize /')
keymap('x', '<Leader>tb', ':Tabularize /')
-- nnoremap <Leader>tbox :Tabularize /*<Return>vip<Esc>:substitute/ /=/g<Return>r A/<Esc>vipo<Esc>0r/:substitute/ /=/g<Return>:nohlsearch<Return>

vim.g.next_object_prev_letter = 'v'

-- Replace with register
keymap('n', 'gh', '<Plug>ReplaceWithRegisterOperator', {noremap = false})
keymap('n', 'ghh', '<Plug>ReplaceWithRegisterLine', {noremap = false})
keymap('x', 'gh', '<Plug>ReplaceWithRegisterVisual', {noremap = false})

-- Auto pairs
vim.g.AutoPairs = {
    ['('] = ')', ['['] = ']', ['{'] = '}',
    ['"'] = '"', ["'"] = "'", ['`'] = '`',
    ['¿'] = '?', ['¡'] = '!'
}
-- }}}

-- Variables definidas por mi {{{
local envolver_lineas_largas = true
local usar_portapapeles_del_sistema = false
local usar_respaldo_local = true
-- }}}

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

-- Lista de colores para recorrerlos mediante un
local lista_colores = {
    '256_noir', 'PaperColor', 'abstract', 'alduin', 'angr', 'apprentice',
    'challenger_deep', 'deus', 'gruvbox', 'gotham256', 'hybrid',
    'hybrid_material', 'jellybeans', 'lightning', 'lucid', 'lucius',
    'materialbox', 'meta5', 'minimalist', 'molokai', 'molokayo', 'nord', 'one',
    'onedark', 'paramount', 'rdark-terminal2', 'scheakur', 'seoul256-light',
    'sierra', 'tender', 'two-firewatch'
}

local function indexof(list, value)
    local index = -1
    for k, v in pairs(list) do
        if v == value then
            index = k
        end
    end

    return index
end

local posicion_actual_colorscheme = indexof(lista_colores, 'tender')

local function setColorschemeToIndex()
    local tema = lista_colores[posicion_actual_colorscheme]
    local comando = 'colorscheme ' .. tema
    vim.cmd(comando)

    if tema == 'two-firewatch' or tema == 'lucid' or tema == 'paramount' then
        vim.cmd('set background=dark')
    end

    -- Se hacen más visibles un par de elementos
    if tema == 'tender' then
        vim.cmd [[
        highlight SpellBad guibg=NONE guifg=#f43753 ctermbg=NONE ctermfg=203
        highlight SpellCap guibg=NONE guifg=#9faa00 ctermbg=NONE ctermfg=142
        highlight SpellRare guibg=NONE guifg=#d3b987 ctermbg=NONE ctermfg=180
        highlight SpellLocal guibg=NONE guifg=#ffc24b ctermbg=NONE ctermfg=215

        " highlight ColorColumn guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=12 gui=NONE cterm=NONE
        " highlight CursorColumn guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=3 gui=NONE cterm=NONE
        " highlight CursorLine guifg=NONE ctermfg=NONE guibg=#000000 ctermbg=3 gui=NONE cterm=NONE
        highlight LineNr guifg=#b3deef ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
        highlight Comment guifg=#c9d05c ctermfg=185 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
        highlight FoldColumn guifg=#ffffff ctermfg=15 guibg=#202020 ctermbg=234 gui=NONE cterm=NONE
        ]]
    end
end

setColorschemeToIndex()

function RotarColor()
    posicion_actual_colorscheme = posicion_actual_colorscheme + 1
    if posicion_actual_colorscheme > #lista_colores then
        posicion_actual_colorscheme = 1
    end

    setColorschemeToIndex()
end

-- Caracteres invisibles
vim.o.list = true       -- Mostrar caracteres invisibles según las reglas de 'listchars'
vim.o.listchars = 'tab:»·,trail:·,extends:❯,precedes:❮'

vim.o.conceallevel = 0      -- Permite texto "camuflajeado"
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
--    :lua CambiarIndentacion(8)<Return>
-- Si se quiere una re-indentación automática de todo el texto ya existente
-- pasar un valor verdadero como segundo argumento
--    :lua CambiarIndentacion(8, true)<Return>

function CambiarIndentacion(espacios, --[[Optional]] reindentar)
    reindentar = reindentar or false

    vim.bo.tabstop = espacios
    vim.bo.shiftwidth = espacios
    vim.bo.softtabstop = espacios

    if reindentar then
        vim.cmd [[execute "normal! gg=G\<C-o>\<C-o>"]]
    end
end
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

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

vim.cmd[[
command! DiffOrigen vert new | set buftype=nofile | read ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis
]]
--- }}}

--- Ventanas {{{
-- Dirección para abrir nuevas ventanas (splits)
vim.o.splitright = true  -- Las separaciones verticales se abren a la derecha
vim.o.splitbelow = true  -- Las separaciones horizontales se abren hacia abajo

-- diffsplit prefiere orientación vertical
vim.o.diffopt = vim.o.diffopt .. ',vertical'

-- Redimensionar las ventanas
keymap('n', '<C-w>-', ":<C-u>call RepetirRedimensionadoVentana('-', v:count)<Return>")
keymap('n', '<C-w>+', ":<C-u>call RepetirRedimensionadoVentana('+', v:count)<Return>")
keymap('n', '<C-w><', ":<C-u>call RepetirRedimensionadoVentana('<', v:count)<Return>")
keymap('n', '<C-w>>', ":<C-u>call RepetirRedimensionadoVentana('>', v:count)<Return>")

vim.cmd [[
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
keymap('n', '<Leader>tn', ':tabnew<Space>')
keymap('n', '<Leader>to', ':tabonly<Return>')

-- Moverse entre tabulaciones
keymap('n', '<Leader>th', ':tabfirst<Return>')
keymap('n', '<Leader>tl', ':tablast<Return>')
keymap('n', '<Leader>tj', ':tabprevious<Return>')
keymap('n', '<Leader>tk', ':tabnext<Return>')

-- Mover la tabulación actual
keymap('n', '<Leader>t-', ':tabmove -<Return>')
keymap('n', '<Leader>t+', ':tabmove +<Return>')
keymap('n', '<Leader>t<', ':tabmove 0<Return>')
keymap('n', '<Leader>t>', ':tabmove $<Return>')

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
keymap('n', '<Leader>bn', ':edit<Space>')
keymap('n', '<Leader>bg', ':ls<Return>:buffer<Space>')
keymap('n', '<Leader>bh', ':bfirst<Return>')
keymap('n', '<Leader>bk', ':bnext<Return>')
keymap('n', '<Leader>bj', ':bprevious<Return>')
keymap('n', '<Leader>bl', ':last<Return>')

-- Cerrar ventana, buffer o tabulaciones
keymap('n', '<Leader>bd', ':bdelete!<Return>')

-- Cambiar el directorio de trabajo al directorio del buffer actual
keymap('n', '<Leader>cd', ':cd %:p:h<Return>:pwd<Return>')
-- }}}

-- Movimiento en modo normal {{{
-- Moverse por líneas visuales en lugar de lineas lógicas
keymap('n', 'j',  'gj')
keymap('n', 'k',  'gk')
keymap('n', 'gj', 'j')
keymap('n', 'gk', 'k')

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
keymap('c', '<C-a>', '<Home>')
keymap('c', '<C-b>', '<Left>')
keymap('c', '<C-f>', '<Right>')
keymap('c', '<A-b>', '<S-Left>')
keymap('c', '<A-f>', '<S-Right>')
keymap('c', '<C-d>', '<Del>')
keymap('c', '<A-d>', '<S-Right><C-w>')
keymap('c', '<A-D>', '<C-e><C-u>')

keymap('c', '<C-p>', '<Up>')
keymap('c', '<C-n>', '<Down>')

keymap('c', '<Up>',   '<C-p>')
keymap('c', '<Down>', '<C-n>')
-- }}}

-- Dobleces (folds) {{{
vim.o.foldenable = true         -- Habilitar dobleces
vim.o.foldcolumn = 'auto'       -- Una columna para mostrar la extensión de un dobles
vim.cmd [[set foldopen-=block]] -- No abrir dobleces al presionar }, ), etc...
vim.o.foldnestmax = 3           -- Máxima profundidad de los dobleces

-- Abrir y cerrar dobleces
keymap('n', '<Space>', 'za')
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
keymap('n', 'ñ', '"')
keymap('x', 'ñ', '"')

-- Hacer que Y actúe como C y D
keymap('n', 'Y', 'y$')

-- Mover lineas visuales hacia arriba y hacia abajo
local yes_remap = { noremap = false }
keymap('n', '<A-y>', '<Plug>(textmanip-duplicate-up)', yes_remap)
keymap('x', '<A-y>', '<Plug>(textmanip-duplicate-up)', yes_remap)
keymap('n', '<A-Y>', '<Plug>(textmanip-duplicate-down)', yes_remap)
keymap('x', '<A-Y>', '<Plug>(textmanip-duplicate-down)', yes_remap)

keymap('x', '<A-j>', '<Plug>(textmanip-move-down)', yes_remap)
keymap('n', '<A-j>', '<Plug>(textmanip-move-down)', yes_remap)
keymap('n', '<A-k>', '<Plug>(textmanip-move-up)', yes_remap)
keymap('x', '<A-k>', '<Plug>(textmanip-move-up)', yes_remap)

local expr_and_remap = { expr = true, noremap = false }
keymap('n', '<A-h>', [['<Esc>v' . (v:count ? v:count : 1) . '<A-h><Esc>']], expr_and_remap)
keymap('x', '<A-h>', '<Plug>(textmanip-move-left)', yes_remap)
keymap('n', '<A-l>', [['<Esc>v' . (v:count ? v:count : 1) . '<A-l><Esc>']], expr_and_remap)
keymap('x', '<A-l>', '<Plug>(textmanip-move-right)', yes_remap)

keymap('x', '<Up>'   , '<Plug>(textmanip-move-up-r)', yes_remap)
keymap('x', '<Down>' , '<Plug>(textmanip-move-down-r)', yes_remap)
keymap('x', '<Left>' , '<Plug>(textmanip-move-left-r)', yes_remap)
keymap('x', '<Right>', '<Plug>(textmanip-move-right-r)', yes_remap)

-- Mantener el modo visual después de > y <
keymap('x', '<', '<gv')
keymap('x', '>', '>gv')
-- }}}

--- Operaciones comunes de modificación de texto {{{
-- j: Eliminar caracter de comentario al unir líneas
-- l: Partir líneas cuando se hagan muy largas
vim.o.formatoptions = vim.o.formatoptions .. ',j,l'

-- Regresar rápido a modo normal
keymap('i', 'kj', '<Esc>')

-- Seleccionando texto significativo
keymap('n', 'gV', '`[v`]') -- Texto previamente insertado

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
keymap('i', '<A-k><A-j>', '<Esc>ddkk')
keymap('i', '<A-j><A-k>', '<Esc>ddj')

-- Añadir línea vacía por arriba y por debajo
keymap('n', '<A-o>', ":call append(line('.'), '')<Return>")
keymap('n', '<A-O>', ":call append(line('.')-1, '')<Return>")

-- Borrar todo de la línea de comandos excepto el propio comando
vim.cmd [[ cnoremap <A-w> <C-\>esplit(getcmdline(), " ")[0]<return><space> ]]

-- Aumentar la granularidad del undo
keymap('i', '<C-u>',    '<C-g>u<C-u>')
keymap('i', '<Return>', '<C-g>u<Return>')
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
keymap('n', '//', ':nohlsearch<Return>')
--- }}}

--- Hacks para la búsqueda y remplazo {{{
-- Hacer que el comando . (repetir edición) funcione en modo visual
keymap('x', '.', ':normal .<Return>')

-- Repitiendo sustituciones con todo y sus banderas
keymap('n', '&', ':&&<Return>')
keymap('x', '&', ':&&<Return>')

-- Repitiendo el último comando de consola
keymap('n', 'Q', '@:')
keymap('x', 'Q', '@:')

-- No moverse cuando se busca con * y #
keymap('n', '*', '*N')
keymap('n', '#', '#N')

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
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

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
keymap('n', '<Leader>ss', ':s/')
keymap('x', '<Leader>ss', ':s/')
keymap('n', '<Leader>se', ':%s/')
keymap('x', '<Leader>se', ':<C-u>call SeleccionVisual()<Return>:%s/<C-r>=@/<Return>/')
keymap('n', '<Leader>sw', ':%s/\\<<C-r><C-w>\\>\\C/')
keymap('n', '<Leader>sW', ':%s/<C-r>=expand("<cWORD>")<Return>\\C/')

-- }}}
--- ##### }}}

--- ##### Guardando, saliendo y regresando a vim ##### {{{
vim.o.fileformats = 'unix,dos,mac'  -- Formato para los saltos de línea
vim.o.autowrite   = true            -- Guardado automático en ciertas ocasiones
vim.o.autoread    = true            -- Recargar el archivo si hay cambios
vim.opt.backupdir:remove({'.'})     -- No guardar respaldos en el directorio actual,
                                    -- usa cualquier otra ubicación de la lista

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
keymap('n', 'ZG', ':xa<Return>')
keymap('n', 'ZA', ':quitall!<Return>')

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
keymap('n', '<C-s>', ':update<Return>')
keymap('i', '<C-s>', '<Esc>:update<Return>a')

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
--                      ---- Aquí seguramente falta shellescape(nombre_ejecutable)
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

--- +++ Detección de tipos de archivo, y configuraciones locales +++ {{{
vim.cmd [[
augroup DeteccionLenguajes
    autocmd!
    autocmd BufNewFile,BufRead *.nasm setlocal filetype=nasm
    autocmd BufNewFile,BufRead *.jade setlocal filetype=pug
    autocmd BufNewFile,BufRead *.h    setlocal filetype=c
    autocmd BufNewFile,BufRead *.clp  setlocal filetype=clips nospell
    autocmd BufNewFile,BufRead *.pl  setlocal filetype=prolog nospell

    autocmd BufReadPre /home/saul/Documentos/grassmann/*.tex
        \ let b:vimtex_main = '/home/saul/Documentos/grassmann/main.tex'

augroup END
]]
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

vim.cmd [[
augroup ConfiguracionComando
    autocmd!
    " Por defecto se usa el comando :Man a su vez llama al man del sistema
    autocmd FileType vim,help setlocal keywordprg=:help
    " Se requiere tener instalado cppman para usar ayuda en c++
    autocmd FileType cpp setlocal keywordprg=:!cppman
    " autocmd FileType cpp nnoremap <buffer> K yiw:sp<CR>:terminal<CR>Acppman <C-\><C-n>pA<CR>
augroup end
]]
---   +++ }}}
--- ### }}}

--- ##### Edición y evaluación de la configuración y comandos ##### {{{
--- Modificar y evaluar el archivo de configuración principal y el de plugins
keymap('n', '<Leader>av', ':edit $MYVIMRC<Return>')
keymap('n', '<Leader>sv', ':source $MYVIMRC<Return>')

--- Evaluar por medio de la consola externa por medio (EValuate Shell)
local shell = 'bash'

if has('windows') then
    shell = 'cmd'
end

keymap('n', '<Leader>evs', '!!' .. shell .. ' <Return>')
keymap('x', '<Leader>evs', '!' .. shell .. ' <Return>')

--- Abrir emulador de terminal (open terminal)
keymap('n', '<Leader>ot', ':5sp<bar>te<CR>:setlocal nospell nonu<Return>A')

--- Mandar un comando a la terminal abierta
local terminal_new_line = "\n"
if has('windows') then
    terminal_new_line = "\r\n"
end

local function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function Send_to_terminal(v)
    local term_buf_id = -1
    for _, buf_id in ipairs(vim.fn.tabpagebuflist()) do
        local buf_type = vim.api.nvim_buf_get_option(buf_id, "buftype")
        if buf_type == "terminal" then
            term_buf_id = buf_id
            local text = ""
            if v then
                -- Get selected lines
                local buf = vim.api.nvim_get_current_buf()
                local line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
                local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
                text = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)
                text = trim(table.concat(text, terminal_new_line))
            else
                -- Get current line
                text = trim(vim.api.nvim_get_current_line())
            end
            local chan_id = vim.api.nvim_buf_get_var(term_buf_id, "terminal_job_id")
            vim.api.nvim_chan_send(chan_id, text .. terminal_new_line)
        end
    end
end
keymap('n', '<Leader>evt', '<cmd>lua Send_to_terminal()<CR>')
keymap('x', '<Leader>evt', '<cmd>lua Send_to_terminal(true)<CR>')

--- Salir a modo normal en la terminal emulada
---tnoremap <Esc> <C-\><C-n>

--- Evaluación de un comando de modo normal por medio de <Leader>evn
keymap('n', '<Leader>evn', '^vg_y@"')
keymap('x', '<Leader>evn', 'y@"')

--- Evaluación de un comando de VimL (modo comando) por medio de <Leader>evv
keymap('n', '<Leader>evv', ':execute getline(".")<Return>',
       {silent = true})
keymap('x', '<Leader>evv', ':<C-u>' ..
             '      for linea in getline("\'<", "\'>")' ..
             '<bar>     execute linea' ..
             '<bar> endfor' ..
             '<Return>')

--- Pegar la salida de un comando de vim en un buffer nuevo
--- Modo de uso: SalidaBuffer {comando-normal}
vim.cmd [[
command! -nargs=* -complete=command SalidaBuffer call SalidaBuffer(<q-args>)
function! SalidaBuffer(comando)
    redir => l:salida
    silent exe a:comando
    redir END

    new
    setlocal nonumber
    call setline(1, split(l:salida, "\n"))
    setlocal nomodified
endfunction
]]
--- ### }}}

--- ##### Completado, etiquetas, diccionarios y revisión ortográfica ##### {{{
vim.o.complete = vim.o.complete .. ',i,t'

--- Generar etiquetas de definiciones y comando "go to definition"
--set tags=./tags;/,~/.vimtags

if not vim.fn.executable('ctags') then
    print('Se requiere alguna implementación de ctags para generar etiquetas')
    print('del lenguaje para usar algunos comandos (y posiblemente plugins).')
end
keymap('n', '<Leader>ut', ':!ctags -R .&<Return>')
--<C-]> - Ir a la definición del objeto (solo si ya se generaron las etiquetas)

vim.o.spell = true
vim.o.spelllang = 'es,en'


--- Recorrer las palabras mal escritas y corregirlas
--Siguiente error ortográfico: ]s
--Anterior error ortográfico: [s

--- Modificar lista de palabras aceptadas
--zg - Añadir palabra a la lista blanca
--zw - Quitar palabra de la lista blanca (marcarla como incorrecta)
--z= - Mostrar opciones de corrección para una palabra mal escrita
--1z= - Elegir la primera opción de la lista

--- ### }}}
-- vim: foldmethod=marker
