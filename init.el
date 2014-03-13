(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(require 'cl)
(require 'init-packages)
(require 'init-util)
(require 'init-core)

(defcustom dotemacs-modules '(init-eshell
                              init-org
                              init-eyecandy

                              init-smartparens
                              ;; init-autopair

                              init-yasnippet
                              init-auto-complete
                              ;; init-company

                              init-projectile
                              init-helm
                              init-ido

                              init-git
                              init-flycheck

                              init-vim
                              init-stylus
                              init-js
                              init-web
                              init-lisp
                              init-markdown

                              init-misc
                              init-evil
                              init-bindings

                              init-overrides)
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))
