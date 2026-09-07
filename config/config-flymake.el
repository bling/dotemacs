;; -*- lexical-binding: t -*-

(add-hook 'prog-mode-hook #'flymake-mode)
(add-hook 'text-mode-hook #'flymake-mode)

(use-package flymake-collection
  :config
  (flymake-collection-hook-setup)
  (setf (alist-get 'emacs-lisp-mode flymake-collection-hook-config) nil))

(defun /flymake/disable-dotfiles-elisp-checkers ()
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-byte-compile t)
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-checkdoc t))

(add-hook 'emacs-lisp-mode-hook #'/flymake/disable-dotfiles-elisp-checkers)

(provide 'config-flymake)
