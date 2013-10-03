(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (concat user-emacs-directory "config"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'init-core)
(require 'init-util)
(require 'init-eyecandy)

(require 'init-editor)
(require 'init-smartparens)

(require 'init-yasnippet)
(require 'init-auto-complete)
; (require 'init-company)

(require 'init-projectile)
(require 'init-helm)
(require 'init-ido)

(require 'init-git)
(require 'init-flycheck)

(require 'init-vim)
(require 'init-web)
(require 'init-lisp)
(require 'init-markdown)

(require 'init-evil)
(require 'init-bindings)

;;; (unload-feature 'foo)
