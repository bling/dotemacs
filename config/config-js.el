;; -*- lexical-binding: t -*-

(defgroup dotemacs-js nil
  "Configuration options for Javascript."
  :group 'dotemacs
  :prefix 'dotemacs-js)

(defcustom dotemacs-js/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-js)

(defcustom dotemacs-js/engine 'lsp
  "Whether to activate enhanced LSP functionalities."
  :type '(radio
          (const :tag "lsp" lsp)
          (const :tag "eglot" eglot))
  :group 'dotemacs-js)



(setq js-indent-level dotemacs-js/indent-offset)

(defun /js/setup ()
  (cond
   ((eq dotemacs-js/engine 'lsp)
    (/lsp/activate))
   ((eq dotemacs-js/engine 'eglot)
    (/eglot/activate))))

(when (fboundp 'js-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.[mc]?js\\'" . js-ts-mode))
  (add-hook 'js-ts-mode-hook #'/js/setup))

(when (fboundp 'tsx-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-ts-mode))
  (add-hook 'tsx-ts-mode-hook #'/js/setup))

(provide 'config-js)
