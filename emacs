(load-theme 'misterioso)

; Usar cursor con forma de barrita cuadrada
(set-default 'cursor-typel
             'hbar)

(blink-cursor-mode 0)

; Sin barra de menU
(menu-bar-mode 0)

; Sin barra de opciones
(tool-bar-mode 0)

; Sin scroll lateral
(scroll-bar-mode 0)

; Capacidad de escribir acentos
(require 'iso-transl)

; Ver numeraciOn de lIneas
(global-linum-mode t)

; Mostrar el parentesis correspondiente
(show-paren-mode)

; Insertar el parEntesis/corchete/llave de cierre cuando se presione
; la de apertura
(electric-pair-mode)

; Usar espacios en lugar de tabulaciones
(setq-default indent-tabs-mode nil)

; Usar 4 espacios por cada tabulaciOn
(setq tab-width 4)

; De nuevo 4 espacios, pero esta vez especificamente para archivos de C
(setq-default c-basic-offset 4)

;; ; Estilo de indentaciOn para modo C
;; (setq c-default-style '((java-mode . "java")
;;                         (awk-mode . "awk")
;;                         (other . "linux")))

; Resaltar la lInea de escritura
(global-hl-line-mode t)

; Un tamanio de fuente considerable
(set-frame-font "Ubuntu Mono-10" nil t)

; Desactivar la creación de archivos extra
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Repositorios de paquetes
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

(require 'let-alist)

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

(require 'key-chord)
(key-chord-mode 1)

(require 'evil-commentary)
(evil-commentary-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-args)
(define-key evil-inner-text-objects-map "," 'evil-inner-arg)
(define-key evil-outer-text-objects-map "," 'evil-outer-arg)
(define-key evil-normal-state-map ",n" 'evil-forward-arg)
(define-key evil-normal-state-map ",N" 'evil-backward-arg)
;; (define-key evil-motion-state-map ",n" 'evil-forward-arg)
;; (define-key evil-motion-state-map ",p" 'evil-backward-arg)
(define-key evil-normal-state-map ",o" 'evil-jump-out-args)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

(require 'emmet-mode)
(emmet-mode 1)

(require 'telephone-line)
(telephone-line-mode 1)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-trail trailing))
(global-whitespace-mode t)

(require 'flycheck)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(global-flycheck-mode)

; Para emacs 25 o superior:
;(require 'fill-column-indicator)

; Salir de modo normal presionando "kj"
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
