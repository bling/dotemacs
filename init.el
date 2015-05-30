(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(defcustom dotemacs-completion-engine
  'company
  "The completion engine the use."
  :type '(radio
          (const :tag "company-mode" company)
          (const :tag "auto-complete-mode" auto-complete))
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "/config"))
(let ((base (concat user-emacs-directory "/elisp")))
  (add-to-list 'load-path base)
  (dolist (dir (directory-files base t "^[^.]"))
    (when (file-directory-p dir)
      (add-to-list 'load-path dir))))

(require 'cl)
(require 'init-packages)
(require 'init-util)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((debug-on-error t))
  (require 'init-core)

  (require 'init-eshell)
  (require 'init-erc)

  (if (eq dotemacs-completion-engine 'company)
      (require 'init-company)
    (require 'init-auto-complete))

  (require 'init-lisp)
  (require 'init-org)
  (require 'init-vim)
  (require 'init-stylus)
  (require 'init-js)
  (require 'init-go)
  (require 'init-web)
  (require 'init-markup)

  (require 'init-projectile)
  (require 'init-helm)
  (require 'init-ido)
  (require 'init-vcs)
  (require 'init-flycheck)
  (require 'init-yasnippet)
  (require 'init-smartparens)
  (require 'init-misc)

  (require 'init-evil)
  (require 'init-macros)
  (require 'init-eyecandy)

  (require 'init-bindings))
