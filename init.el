
(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "config"))

(require 'cl)
(require 'init-packages)
(require 'init-util)

(let ((base (concat user-emacs-directory "elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t))
    (when (and (file-directory-p dir)
               (not (equal (file-name-nondirectory dir) ".."))
               (not (equal (file-name-nondirectory dir) ".")))
      (add-to-list 'load-path dir))))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(defcustom dotemacs-modules
  '(init-core

    init-eshell
    init-org
    init-erc
    init-eyecandy

    init-smartparens

    init-yasnippet
    ;; init-auto-complete
    init-company

    init-projectile
    init-helm
    init-ido

    init-vcs
    init-flycheck

    init-vim
    init-stylus
    init-js
    ;; init-go
    init-web
    init-lisp
    init-markdown

    init-misc
    init-evil
    init-bindings
    init-macros

    init-overrides)
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(add-to-list 'after-init-hook
             (lambda ()
               (dolist (module dotemacs-modules)
                 (with-demoted-errors "######## INIT-ERROR ######## %s"
                   (require module)))))
