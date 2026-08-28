;; -*- lexical-binding: t -*-

(defun /eglot/activate ()
  (use-package eglot :demand t)
  (when (eglot--lookup-mode major-mode)
    (eglot-ensure)))

(after 'eglot
  (setq eglot-autoshutdown t)

  (when (executable-find "tsgo")
    (add-to-list 'eglot-server-programs
                 `((typescript-ts-mode tsx-ts-mode js-ts-mode js-mode)
                   . ("tsgo" "--lsp" "--stdio")))))

(provide 'config-eglot)
