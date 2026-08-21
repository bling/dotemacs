;; -*- lexical-binding: t -*-

(defgroup dotemacs-eglot nil
  "Configuration options for Eglot."
  :group 'dotemacs
  :prefix 'dotemacs-eglot)

(defun /eglot/activate ()
  (interactive)
  (use-package eglot)
  (eglot-ensure))

(after 'eglot
  (setq eglot-autoshutdown t)

  (when (executable-find "tsgo")
    (add-to-list 'eglot-server-programs
                 `((typescript-ts-mode tsx-ts-mode js-ts-mode js-mode)
                   . ("tsgo" "--lsp" "--stdio")))))

(provide 'config-eglot)
