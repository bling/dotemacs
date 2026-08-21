;; -*- lexical-binding: t -*-

(add-hook 'prog-mode-hook #'flymake-mode-on)
(add-hook 'text-mode-hook #'flymake-mode-on)

(use-package flymake-collection
  :demand t
  :config
  (flymake-collection-hook-setup)
  (setf (alist-get 'emacs-lisp-mode flymake-collection-hook-config) nil))

(defun /flymake/disable-dotfiles-elisp-checkers ()
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-byte-compile t)
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-checkdoc t))

(add-hook 'emacs-lisp-mode-hook #'/flymake/disable-dotfiles-elisp-checkers)

(provide 'config-flymake)
