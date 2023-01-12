;; -*- lexical-binding: t -*-

(defgroup dotemacs-eglot nil
  "Configuration options for Eglot."
  :group 'dotemacs
  :prefix 'dotemacs-eglot)

(defun /eglot/activate ()
  (interactive)
  (require-package 'eglot)
  (eglot-ensure))

(after 'eglot
  (setq eglot-autoshutdown t))

(provide 'config-eglot)
