;; -*- lexical-binding: t -*-

(defgroup dotemacs-js nil
  "Configuration options for Javascript."
  :group 'dotemacs
  :prefix 'dotemacs-js)

(defcustom dotemacs-js/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-js)

(defcustom dotemacs-js/mode
  'js
  "The major mode to drive JavaScript."
  :type '(radio
          (const :tag "js-mode" js-mode)
          (const :tag "js2-mode" js2-mode))
  :group 'dotemacs-js)

(defcustom dotemacs-js/engine
  nil
  "Whether to activate enhanced LSP functionalities."
  :type '(radio
          (const :tag "none" nil)
          (const :tag "lsp" lsp)
          (const :tag "eglot" eglot))
  :group 'dotemacs-js)



(setq js-indent-level dotemacs-js/indent-offset)

(when (eq dotemacs-js/mode 'js2)
  (defun /js/activate-js2 ()
    (require-package 'js2-mode)
    (js2-jsx-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . /js/activate-js2)))

(cond
 ((eq dotemacs-js/engine 'lsp)
  (add-hook 'js-mode-hook #'/lsp/activate)
  (add-hook 'js-jsx-mode-hook #'/lsp/activate))
 ((eq dotemacs-js/engine 'eglot)
  (add-hook 'js-mode-hook #'/eglot/activate)
  (add-hook 'js-jsx-mode-hook #'/eglot/activate)))

(after 'js2-mode
  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset dotemacs-js/indent-offset)

  (require-package 'js2-refactor)
  (require 'js2-refactor)
  (js2r-add-keybindings-with-prefix "C-c C-m")

  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (add-hook 'js2-jsx-mode-hook #'js2-refactor-mode)
  (add-hook 'js2-minor-mode-hook #'js2-refactor-mode))

(provide 'config-js)
