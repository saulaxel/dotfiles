#!/bin/bash

SALIDA=$(~/.vim/cortar)

RET=$?

echo "$SALIDA" | clang-format | ~/.vim/pegar $RET

