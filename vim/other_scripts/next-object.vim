
" Motion for "next/previos object".
" Unfortunately the "p" motion was already taken for paragraphs so it uses v of preVious
"
" Next acts on the next object of the given type in the current line, last acts
" on the previous object of the given type in the current line.
"
" Currently only works for (, [, {, ', and ".
"
" Example:
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')

scriptencoding utf-8

noremap <silent> <plug>AroundNextMap :<c-u>call <SID>NextTextObject('a', 'f', 'AroundNextMap', '')<cr>
noremap <silent> <plug>InnerNextMap  :<c-u>call <SID>NextTextObject('i', 'f', 'InnerNextMap', '')<cr>
noremap <silent> <plug>AroundLastMap :<c-u>call <SID>NextTextObject('a', 'F', 'AroundLastMap', '')<cr>
noremap <silent> <plug>InnerLastMap  :<c-u>call <SID>NextTextObject('i', 'F', 'InnerLastMap', '')<cr>

noremap <silent> <plug>RepeatNextObject :<c-u>call <SID>RepeatNextObject()<cr>
noremap <silent> <plug>RepeatPreviousObject :<c-u>call <SID>RepeatPreviousObject()<cr>

omap an <plug>AroundNextMap
xmap an <plug>AroundNextMap

omap in <plug>InnerNextMap
xmap in <plug>InnerNextMap

omap av <plug>AroundLastMap
xmap av <plug>AroundLastMap

omap iv <plug>InnerLastMap
xmap iv <plug>InnerLastMap

xmap <c-l> <plug>RepeatNextObject
xmap <c-h> <plug>RepeatPreviousObject

let s:lastMotion = 'i'
let s:lastTextObjType = 'b'

function! s:RepeatNextObject()
    call s:NextTextObject(s:lastMotion, 'f', '', s:lastTextObjType)
endfunction

function! s:RepeatPreviousObject()
    call s:NextTextObject(s:lastMotion, 'F', '', s:lastTextObjType)
endfunction

function! s:NextTextObject(motion, dir, plugName, objType)

    let l:c = a:objType
    if empty(l:c)
        let l:c = nr2char(getchar())
    endif

    " Commented out to train on new keys, uncomment when it's learned
    if stridx('b()', l:c) != -1
        call s:SelectNextObject('(', ')', a:motion, a:dir)
    elseif stridx('{}', l:c) != -1
        call s:SelectNextObject('{', '}', a:motion, a:dir)
    elseif stridx('[]', l:c) != -1
        call s:SelectNextObject('[', ']', a:motion, a:dir)
    elseif stridx('"', l:c) != -1
        call s:SelectNextObject('"', '"', a:motion, a:dir)
    elseif l:c ==# "'"
        call s:SelectNextObject("'", "'", a:motion, a:dir)
    elseif stridx('<>', l:c) != -1
        call s:SelectNextObject('<', '>', a:motion, a:dir)
    else 
        echom 'Invalid text object'
        return
    endif

    let s:lastMotion = a:motion
    let s:lastTextObjType = l:c

endfunction

function! s:CountCharsBehind(char, col, line)
    let l:i = 0
    let l:cnt = 0
    while l:i < a:col && l:i < strlen(a:line)
        if a:line[l:i] ==# a:char
            let l:cnt += 1
        endif
        let l:i += 1
    endwhile
    return l:cnt
endfunction

function! s:CountCharsInFront(char, col, line)
    let l:i = strlen(a:line)-1
    let l:cnt = 0
    while l:i > a:col && l:i >= 0
        if a:line[l:i] ==# a:char
            let l:cnt += 1
        endif
        let l:i -= 1
    endwhile
    return l:cnt
endfunction

function! s:SelectNextObject(openChar, closeChar, motion, dir)

    let l:goForward = (a:dir ==# 'f')
    let l:firstChar = l:goForward ? a:openChar : a:closeChar
    let l:lastChar = l:goForward ? a:closeChar : a:openChar

    exe 'normal! mz'
    let l:matchCount = 0

    while 1
        let l:lineCol = col('.')-1
        let l:lineStr = getline('.')

        " Bug fix: also catch cases where it is the last character
        if l:lineStr[l:lineCol] != l:firstChar
            exe 'normal! ' . a:dir . l:firstChar
            let l:lineCol = col('.') - 1
        endif

        if l:lineStr[l:lineCol] ==# l:firstChar

            if a:openChar ==# a:closeChar

                let l:cnt = s:CountCharsInFront(a:openChar, l:lineCol, l:lineStr)

                if l:cnt % 2
                    " Odd number in front, so stop
                    break
                elseif l:cnt > 0
                    " Repeat on current line
                    continue
                endif
            else
                break
            endif
        endif

        if (l:goForward && line('.') ==# line('$')) || (!l:goForward && line('.') == 1)
            exe 'normal! `z'
            exe 'delm z'
            echom 'No match found'
            return
        endif

        if l:goForward
            exe 'normal! j0'
        else
            exe 'normal! k$'
        endif
    endwhile

    " Check if the object is empty
    if (l:goForward && l:lineStr[l:lineCol+1] ==# l:lastChar)
                \|| (!l:goForward && l:lineStr[l:lineCol-1] ==# l:lastChar)
        " If our custom text object ends with text visually selected then that text is 
        " operated on
        " If it doesn't then vim will operate on the range from the old cursor position
        " to the new one
        " This is a problem because we want to move the cursor between brackets when they are empty
        " So create a dummy character and select that.  This will allow din( to work.
        " It means that vin( will create the character but I don't see another option, 
        " also, there's no reason to do vin( if the range is empty anyway
        if l:goForward
            exe 'normal! a '
        else
            exe 'normal! i '
        endif
        exe 'normal! v'
        exe 'delm z'
        return
    endif

    if a:openChar ==# a:closeChar
        let l:line = getline('.')
        let l:col = col('.') - 1

        if l:goForward
            let l:cnt = s:CountCharsBehind(a:openChar, l:col, l:line)
        else
            let l:cnt = s:CountCharsInFront(a:openChar, l:col, l:line)
        endif

        " Search again to avoid selecting the one we are in
        if l:cnt % 2
            exe 'normal! ;'
        endif
    endif

    exe 'normal! v' . a:motion . a:openChar
    exe 'delm z'
endfunction
