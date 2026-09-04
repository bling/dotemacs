;; -*- lexical-binding: t -*-

(defun /eglot/activate ()
  (require 'eglot)
  (when (eglot--lookup-mode major-mode)
    (eglot-ensure)))

(after 'eglot
  (setq eglot-autoshutdown t)

  (let ((cmd (cond ((executable-find "vtsls") '("vtsls" "--stdio"))
                   ((executable-find "tsgo")  '("tsgo" "--lsp" "--stdio")))))
    (when cmd
      (add-to-list 'eglot-server-programs
                   `((typescript-ts-mode tsx-ts-mode js-ts-mode js-mode)
                     . ,cmd)))))

(provide 'config-eglot)
